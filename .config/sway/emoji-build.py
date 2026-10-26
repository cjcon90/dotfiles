#!/usr/bin/env python3
# Builds the emoji and symbol lists for emoji-menu.sh from Unicode data. Delete the output to refresh.

import json
import subprocess
import unicodedata
import urllib.request
from pathlib import Path

TEST = "https://unicode.org/Public/emoji/latest/emoji-test.txt"
CLDR = "https://raw.githubusercontent.com/unicode-org/cldr-json/main/cldr-json"
ANNOTATIONS = [
    f"{CLDR}/cldr-annotations-full/annotations/en/annotations.json",
    f"{CLDR}/cldr-annotations-derived-full/annotationsDerived/en/annotations.json",
]
OUT = Path.home() / ".cache/emoji-menu"

SYMBOLS = {
    "arrows": "←→↑↓↔↕⇐⇒⇑⇓⇔↩↪⟶⟵",
    "marks": "✓✔✗✘•·…—–‘’“”«»§¶†‡©®™°′″",
    "math": "×÷±≈≠≤≥∞√∑∏∆∂∫∈∉∩∪⊂⊃∀∃¬∧∨⊕",
    "fractions, powers": "½⅓⅔¼¾²³¹ⁿ",
    "currency": "€£¥¢₿",
    "greek": "αβγδεθλμπστφψωΔΣΦΩ",
    "misc": "★☆♥♦♣♠♪♫☀☁☂☎✉✂✎",
    "keys": "⌘⌥⇧⌃⏎⌫⌦⎋⇥␣",
}


def fetch(url):
    with urllib.request.urlopen(url) as r:
        return r.read().decode()


def font_codepoints():
    font = subprocess.run(["fc-match", "-f", "%{file}", "emoji"], capture_output=True, text=True).stdout
    charset = subprocess.run(["fc-query", "-f", "%{charset}", font], capture_output=True, text=True).stdout
    points = set()
    for part in charset.split():
        lo, _, hi = part.partition("-")
        points.update(range(int(lo, 16), int(hi or lo, 16) + 1))
    return points


def is_variant(emoji, name, names):
    if any(0x1F3FB <= ord(c) <= 0x1F3FF for c in emoji) or "facing right" in name:
        return True
    if name.startswith(("family:", "couple with heart:", "kiss:")) or name.endswith(("o’clock", "-thirty")):
        return True
    # Gendered versions of an emoji that also has a neutral one
    for gender, neutral in (("man", "person"), ("woman", "person"), ("men", "people"), ("women", "people")):
        if name.startswith(f"{gender} ") or name.startswith(f"{gender}:"):
            rest = name[len(gender):].lstrip(" ")
            return rest in names or f"{neutral} {rest}" in names or f"{neutral}{rest}" in names
        if name.endswith(f" {gender}"):
            return f"{name[:-len(gender)]}{neutral}" in names
    return False


keywords = {}
for url in ANNOTATIONS:
    data = json.loads(fetch(url))
    for emoji, ann in next(iter(data.values()))["annotations"].items():
        keywords[emoji] = ann.get("default", [])

entries = []
group = ""
for line in fetch(TEST).splitlines():
    if line.startswith("# group: "):
        group = line.removeprefix("# group: ").lower()
    elif "; fully-qualified" in line:
        emoji, version, name = line.split("# ", 1)[1].split(" ", 2)
        entries.append((emoji, float(version[1:]), name, group))

# Skip emoji newer than the installed emoji font can draw
drawable = font_codepoints()
missing = [v for e, v, _, _ in entries if len(e) == 1 and ord(e) not in drawable]
newest = min(missing) - 0.01 if missing else float("inf")
names = {name for _, _, name, _ in entries}

rows = []
for emoji, version, name, group in entries:
    if version <= newest and not is_variant(emoji, name, names):
        # CLDR keys drop the emoji presentation selector
        words = keywords.get(emoji) or keywords.get(emoji.replace("\ufe0f", ""), [])
        tags = " · ".join(filter(None, [group, ", ".join(words)]))
        rows.append(f"{emoji}\t{name}\t{tags}")

symbols = [f"{s}\t{unicodedata.name(s).lower()}\t{label}" for label, chars in SYMBOLS.items() for s in chars]

OUT.mkdir(parents=True, exist_ok=True)
(OUT / "emoji.tsv").write_text("\n".join(rows) + "\n")
(OUT / "symbols.tsv").write_text("\n".join(symbols) + "\n")
print(f"{len(rows)} emoji and {len(symbols)} symbols written to {OUT}")
