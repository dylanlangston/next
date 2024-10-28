const colors = require('tailwindcss/colors');
const colorsToSkip = ['lightBlue', 'warmGray', 'trueGray', 'coolGray', 'blueGray'];
const filteredColors = Object.keys(colors)
  .filter(color => !colorsToSkip.includes(color))
  .reduce((obj, key) => {
    obj[key] = colors[key];
    return obj;
  }, {});

/** @type {import('tailwindcss').Config} */
export default {
	darkMode: ['variant', [
		'@media (prefers-color-scheme: dark) { &:not(.light *) }',
		'&:is(.dark *)',
	]],
	content: ['./src/**/*.{html,js,svelte,ts,css}'],
	theme: {
		colors: {
			...filteredColors,
			main: 'var(--Main)'
		},
		extend: {
			keyframes: {
				'fade-in': {
					'0%, 50%': { opacity: 0 },
					'100%': { opacity: 1 },
				},
				'fade-out': {
					'0%, 50%': { opacity: 1 },
					'100%': { opacity: 0 },
				},
				'blur-in': {
					'to': {
						'filter': 'blur(0)',
						'backdrop-filter': 'blur(16px)'
					},
				}
			},
			animation: {
				glass: 'blur-in 200ms 300ms linear forwards',
			}
		},
		fontFamily: {
			emoji: ["Apple Color Emoji", "Segoe UI Emoji", "Noto Color Emoji", "Android Emoji", "EmojiSymbols", "EmojiOne Mozilla", "Twemoji Mozilla", "Segoe UI Symbol", "Noto Color Emoji Compat", "emoji", "noto-emojipedia-fallback"]
		},
	},
	plugins: [
		function ({ addBase, theme }) {
			addBase({
				':root': {
					'--Main': 'rgba(128,128,128,0.5)',
				},
			});
		},
	],
}