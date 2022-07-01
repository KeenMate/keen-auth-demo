import {pushSocketMessage} from "./common"
import {Channel} from "./channel"

const groupsChannel = new Channel("groups:lobby")

export async function searchGroups(search) {
	const channel = await groupsChannel.get()

	return await pushSocketMessage(channel, "get_groups", {search})
}

export async function getGroup(groupId) {
	const channel = await groupsChannel.get()

	return await pushSocketMessage(channel, "get_group", {groupId})
}

export async function createGroup(group) {
	const channel = await groupsChannel.get()

	return await pushSocketMessage(channel, "create_group", group)
}

export async function updateGroup(group) {
	const channel = await groupsChannel.get()

	return await pushSocketMessage(channel, "update_group", group)
}

export async function deleteGroup(groupId) {
	const channel = await groupsChannel.get()

	return await pushSocketMessage(channel, "delete_group", {groupId})
}

export default groupsChannel
