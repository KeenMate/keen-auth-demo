import {getConfig, setConfig} from "svelte-adminlte/config.js"

const custom = {
	ContactEmail: "example@keenmate.com"
}


export function getCustomConfig() {
	setConfig(custom)
	return getConfig()
}
