<script>
	import {onDestroy, onMount} from "svelte"
	import {PageHeader} from "svelte-adminlte"
	import {setCustomPageTitle, customPageTitleUsed} from "../stores/page-title"

	onMount(() => {
		customPageTitleUsed.set(true)
		setCustomPageTitle("Loading...")
		setTimeout(() => {
			setCustomPageTitle("Custom Page 1")
		}, 1000)
	})

	onDestroy(() => {
		customPageTitleUsed.set(false)
	})
</script>

<PageHeader>
	Page 1
</PageHeader>

<p>
	Page1 content
</p>
