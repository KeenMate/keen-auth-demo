<script>
	import {Card, Toastr} from "svelte-adminlte"
	import {emptyPromise} from "../../helpers/promise-helpers"
	import {getEmptyGroup} from "../../constants/groups"
	import {createGroup, getGroup, updateGroup} from "../../providers/socket/groups-channel"
	import {Checkbox, FormGroup, Label, LteButton, TextInput} from "svelte-adminlte/src"
	import {push} from "svelte-spa-router"
	import {fillParams, PageUrls} from "../../pages"
	
	export let groupId
	export let isNew
	
	let loading = 0
	
	let group = {}
	let originalTitle = ""
	let groupTask = emptyPromise
	
	$: groupTask = loadGroup(groupId, isNew)
	
	async function onSubmit(ev) {
		ev.stopImmediatePropagation()
		ev.preventDefault()
		
		try {
			loading++

			if (isNew) {
				const newGroup = await createGroup(group)
				Toastr.success("Group created")
				
				push(fillParams(PageUrls.GroupEdit, {id: newGroup.groupId}))
			}
			else {
				const updatedGroup = await updateGroup(group)
				group = {...group, ...updatedGroup}
				Toastr.success("Group updated")
			}
		} catch (error) {
			console.error("Could not submit group", error, group, isNew)
			Toastr.error("Coud not submit group")
		} finally {
			loading--
		}
	}
	
	async function loadGroup(gid, isNew_) {
		if (isNew_)
			return getEmptyGroup()
		
		try {
			loading++
			group = await getGroup(gid)
			originalTitle = group.title
		} catch (error) {
			console.error("Could not load group", error, gid)
			Toastr.error("Could not load group")
		} finally {
			loading--
		}
	}
</script>

<Card loading={loading > 0}>
	<svelte:fragment slot="header">
		{#if isNew}
			New group
		{:else}
			Editing group <strong>{originalTitle}</strong>
		{/if}
	</svelte:fragment>
	
	<form on:submit={onSubmit}>
		<FormGroup>
			<Label>Title</Label>
			<TextInput bind:value={group.title} />
		</FormGroup>
		
		<div class="options">
			<Checkbox bind:checked={group.isAssignable}>
				<Label>Assignable</Label>
			</Checkbox>
			<Checkbox bind:checked={group.isActive}>
				<Label>Active</Label>
			</Checkbox>
		</div>
		
		<LteButton type="submit" small>
			{#if isNew}
				Create group
			{:else}
				Update group
			{/if}
		</LteButton>
	</form>
</Card>

<style lang="sass">
	.options
		display: flex
		align-items: center
		gap: .5rem
</style>
