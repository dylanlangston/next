import { sveltekit } from '@sveltejs/kit/vite';
import { paraglide } from "@inlang/paraglide-js-adapter-sveltekit/vite"
import { defineConfig } from 'vitest/config';
import { resolve, join } from 'path';
import optimizeWASMPlugin from './OptimizeWASMPlugin.ts';
import { getArgs } from './svelte.config.js';
const args = getArgs();


export default defineConfig({
	plugins: [
		paraglide({
			project: "./project.inlang",
			outdir: "./src/lib/paraglide",
		}),
		optimizeWASMPlugin({enabled: !args.Debug}),
		sveltekit()
	],
	assetsInclude: './static/**/*',
	test: {
		include: ['src/**/*.{test,spec}.{js,ts}']
	},
	server: {
		watch: {
			usePolling: true,
		},
		cors: true,
		host: true, // needed for the DC port mapping to work
		strictPort: true,
		port: 5173
	},
	resolve: {
		alias: {
			'next.wasm': resolve('./static/next.wasm')
		}
	},
	ssr: {
		noExternal: ['browser-dtector']
	}
});