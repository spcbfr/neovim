return {
  s('ie', fmta('if err != nil {\n\treturn <err>\n}', { err = i(1, 'err') })),
}
