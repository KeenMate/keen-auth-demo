<script>
	import {createEventDispatcher, tick} from "svelte"
	import {LteButton, Modal, ModalCloseButton} from "svelte-adminlte"
	import {_} from "svelte-i18n"

	const dispatch = createEventDispatcher()

	export async function showModal(m, h) {
		message = m
		header = h
		await tick()

		show()

		return new Promise(resolve => {
			resolveModal = resolve
		})
	}

	export function hideModal() {
		hide()
	}

	let jModalElement
	let show, hide
	let message, header

	let resolveModal

	$: jModalElement && jModalElement.off("hidden.bs.modal", doReject)
	$: jModalElement && jModalElement.on("hidden.bs.modal", doReject)

	function doReject() {
		resolveModal(false)
		hide()
	}

	function doConfirm() {
		resolveModal(true)
		hide()
	}
</script>

<Modal bind:jModalElement bind:show bind:hide>
	<svelte:fragment slot="header">
		{header || ""}
	</svelte:fragment>

	<p>
		{message || ""}
	</p>

	<svelte:fragment slot="actions">
		<ModalCloseButton>
			{$_("common.buttons.close")}
		</ModalCloseButton>

		<LteButton
			color="success"
			small
			on:click={doConfirm}
		>
			<i class="fas fa-check fa-fw"></i> {$_("common.buttons.confirm")}
		</LteButton>
	</svelte:fragment>
</Modal>
