import {writeFile} from "fs"
import svelte from "rollup-plugin-svelte"
import commonjs from "@rollup/plugin-commonjs"
import resolve from "@rollup/plugin-node-resolve"
import replace from "@rollup/plugin-replace"
import html from "@rollup/plugin-html"
import postcss from "rollup-plugin-postcss"
import copy from "rollup-plugin-copy"
import sveltePreprocess from "svelte-preprocess"
import json from "@rollup/plugin-json"
import analyze from "rollup-plugin-analyzer"
import {babel} from "@rollup/plugin-babel"
import {terser} from "rollup-plugin-terser"
import template from "./html-template"

const production = process.env.NODE_ENV === "prod"

const targetDir = "../../priv/static/admin"
// const envReplaceKeyValues = [
// 	"APP_URL",
// 	"BASE_SOCKET_PATH",
// 	"BASE_HTML_TITLE",
// 	"FROALA_ACTIVATION_KEY",
// 	"DEVELOPMENT_FEATURES_ENABLED"
// ].reduce((acc, key) => {acc[`process.env.${key}`] = process.env[key]; return acc}, {})

function serve() {
	let server

	function toExit() {
		if (server) server.kill(0)
	}

	return {
		writeBundle() {
			if (server) return
			server = require("child_process").spawn("npm", ["run", "start"], {
				stdio: ["ignore", "inherit", "inherit"],
				shell: true
			})

			process.on("SIGTERM", toExit)
			process.on("exit", toExit)
		}
	}
}

export default {
	input: "src/main.js",
	output: {
		sourcemap: !production,
		format: "iife",
		name: "app",
		dir: targetDir,
		inlineDynamicImports: true
	},
	plugins: [
		analyze({
			writeTo(string) {
				writeFile("analyzer-output.txt", string, function () {})
			}
		}),
		replace({
			values: {
				"process.env.APP_URL": JSON.stringify(process.env.APP_URL),
				"process.env.BASE_SOCKET_PATH": JSON.stringify(process.env.BASE_SOCKET_PATH),
				"process.env.BASE_HTML_TITLE": JSON.stringify(process.env.BASE_HTML_TITLE)
			}
		}),
		json(),
		svelte({
			compilerOptions: {
				// enable run-time checks when not in production
				dev: !production
			},
			preprocess: sveltePreprocess(),
			onwarn() {
			}
		}),
		postcss({
			extract: true
		}),

		resolve({
			browser: true,
			dedupe: ["svelte"]
		}),

		commonjs(),

		// esbuild({
		// 	minify: production,
		// 	target: [
		// 		"es2020",
		// 		"safari11",
		// 		"edge16",
		// 		"node12",
		// 		// "opera45",
		// 		"chrome58"
		// 	]
		// }),

		babel({
			extensions: [".js", ".mjs", ".html", ".svelte"],
			// runtimeHelpers: true,
			babelHelpers: "bundled",
			exclude: ["node_modules/@babel/**"],
			presets: [
				[
					"@babel/preset-env",
					{
						useBuiltIns: false,
						targets: "> 0.25%, not dead",
					},
				],
			],
			// plugins: [
			// 	"@babel/plugin-syntax-dynamic-import",
			// 	[
			// 		"@babel/plugin-transform-runtime",
			// 		{
			// 			useESModules: true,
			// 		},
			// 	],
			// ],
		}),

		production && terser(),

		html({
			title: process.env.BASE_HTML_TITLE,
			publicPath: "/admin",
			template
		}),

		// copy files that are not frequently modified (for other assets create separate copy plugin)
		copy({
			copyOnce: true,
			targets: [
				{src: "node_modules/jsoneditor/dist/img/jsoneditor-icons.svg", dest: targetDir + "/img"},
				{src: "node_modules/jquery/dist/jquery.min.js", dest: targetDir + "/.." + "/js"},
				{src: "node_modules/jquery-ui-dist/jquery-ui.min.js", dest: targetDir + "/.." + "/js"},
				{src: "node_modules/jquery-ui-dist/jquery-ui.min.css", dest: targetDir + "/.." + "/css"},
				{src: "node_modules/@fortawesome/fontawesome-free/webfonts", dest: targetDir + "/.."},
				{src: "src/locale/*.json", dest: targetDir + "/locales"},
				{src: "src/assets/static/*", dest: targetDir + "/.."}
			]
		})

		// !production && serve(),
		//
		// // Watch the `public` directory and refresh the
		// // browser on changes when not in production
		// !production && livereload("public")
	],
	watch: {
		clearScreen: true
	}
}
