# JpInput

This repo demonstrates an issue with a Japanese input source in macOS Safari
and textareas in forms.

This application is generated with `mix phx.server` and `mix phx.gen.live`.
Other than replacing `type="text"` with `type="textarea"`, no changes were made.

## Observed In

- macOS Sonoma 14.5 (23F79)
- Safari 17.5 (19618.2.12.11.6)
- Phoenix 1.7.14
- Phoenix LiveView from 0.20.2 to 1.0.0-rc.5

## Not Observed In

- Chrome 126.0.6478.63
- Firefox 127.0.1

## Setup

1. `git clone https://github.com/woylie/jp_input`
2. `cd jp_input`
3. `mix setup`
4. `mix phx.server`
5. Add `Japanese - Romaji` as an input source as described here: https://support.apple.com/guide/japanese-input-method/set-up-the-input-source-jpim10267/mac

## Reproduction

1. Open http://localhost:4000/things in Safari.
2. Switch to the Japanese input source.
3. Click `Edit` on the existing thing.
4. Place the cursor at the end of the first line and hit `return` to create a new line in the middle.
5. Type `d` and then `e`.

## What should happen

- After typing `d`, the letter `d` should appear in the textarea with a thick underline.
- After typing `e`, the letter `d` in the textarea should be replaced with a `で`.
- After hitting `return` to confirm the character, the underline disappears.

The thick underline indicates character composition mode, in which you can choose different candidates with the `space` key.

## What really happens

- After typing `d`, the letter `d` appears in the textarea without the underline.
- After typing `e`, the character `え` (e) appears in the textarea. The textarea now contains the text `dえ` instead of `で`.

## Observations

- If you set the cursor _before_ the existing text or in the line _after_ the existing text, character composition works. This is only an issue in the middle of the existing text.
- If you remove the existing text and start typing, character composition works. If you save the changes and open the modal again, the issue comes back.
- If you open http://localhost:4000/things/1/edit directly instead of opening the modal with the `Edit` link, character composition works.
- This is also an issue if the existing text only has latin characters.
- After removing `phx-change` from the form, the issue disappears.

## Resources

- https://support.apple.com/guide/japanese-input-method/set-up-the-input-source-jpim10267/mac
- https://support.apple.com/guide/japanese-input-method/switch-the-input-source-jpimf6ffb247/mac
- https://support.apple.com/guide/japanese-input-method/enter-japanese-text-jpim10265/6.3/mac/14.0
