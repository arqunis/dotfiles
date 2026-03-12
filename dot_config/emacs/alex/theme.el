;;; theme.el --- Theme configuration -*- lexical-binding: t; -*-

;; Colour palette based on Dracula.
(defconst modus-vivendi-palette-overrides
      '((bg-main        "#282a36")
	(bg-dim         "#21222c")
	(bg-alt         "#44475a")
	(bg-hl-line     "#44475a")
	(fg-main        "#f8f8f2")
	(fg-dim         "#bbbbc5")
	(fg-alt         "#f8f8f2")

	(comment        "#6272a4")
	(string         "#f1fa8c")
	(keyword        "#ff79c6")
	(builtin        "#bd93f9")
	(constant       "#bd93f9")
	(type           "#8be9fd")
	(function       "#50fa7b")
	(variable       "#f8f8f2")

	(bg-region      "#44475a")
	(border         "#44475a")
	(cursor         "#f8f8f2")
	(fringe         "#282a36")

	(red            "#ff5555")
	(green          "#50fa7b")
	(yellow         "#f1fa8c")
	(blue           "#8be9fd")
	(magenta        "#ff79c6")
	(cyan           "#8be9fd")
	(orange         "#ffb86c")))

(load-theme 'modus-vivendi t)

;;; theme.el ends here
