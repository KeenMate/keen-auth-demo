<script>
	import {Card, LteButton, TableCondensed, Toastr} from "svelte-adminlte"
	import {emptyPromise} from "../../helpers/promise-helpers"
	import {fillParams, PageUrls} from "../../pages"
	import DeleteItemModal from "../../modals/DeleteItemModal.svelte"
	import {deleteGroup} from "../../providers/socket/groups-channel"

	let showDeleteItemModel
	let hideDeleteItemModel
	
	let loading = 0
	
	let groups = []
	let groupsTask = emptyPromise
	
	async function onDelete({detail: group}) {
		try {
			loading++
			await deleteGroup(group.groupId)
			
			Toastr.success("Group deleted")
		} finally {
			loading--
		}
	}
</script>

<Card loading={loading > 0}>
	<svelte:fragment slot="header">
		Groups
	</svelte:fragment>
	
	<TableCondensed>
		<tr slot="headers">
			<th>Actions</th>
			<th>Title</th>
		</tr>
		
		{#await groupsTask then _}
			{#each groups || [] as group}
				<tr>
					<td class="actions">
						<LteButton xsmall on:click={() => showDeleteItemModel(group)}>
							<i class="fas fa-trash"></i>
						</LteButton>
					</td>
					<td>
						<a href="#{fillParams(PageUrls.Groups)}">
							{group.title}
						</a>
					</td>
				</tr>
			{/each}
		{/await}
	</TableCondensed>
</Card>

<DeleteItemModal
	bind:showModal={showDeleteItemModel}
	bind:hideModal={hideDeleteItemModel}
	let:data
	on:delete={onDelete}
>
	Are you sure you want to delete group <strong>{data.title}</strong>?
</DeleteItemModal>
