<script>
	import {PageHeader} from "svelte-adminlte"
	import {pageIsActive} from "../index"
	import GroupsTableCard from "../../user-controls/groups/GroupsTableCard.svelte"
	import GroupFormCard from "../../user-controls/groups/GroupFormCard.svelte"
	
	export let params = {}
	
	// $: tenantCode = params.tenantCode || null
	$: groupId = params.groupId && Number(params.groupId) || null
	$: isNew = pageIsActive($location, "NewGroup")
</script>

<PageHeader>
	Groups Management
</PageHeader>

<div class="page groups-page">
	<div class="row">
		<div class="col-md-4">
			<GroupsTableCard />
		</div>
		<div class="col-md-8">
			{#if groupId}
				<GroupFormCard
					{groupId}
					{isNew}
				/>
			{/if}
		</div>
	</div>
</div>
