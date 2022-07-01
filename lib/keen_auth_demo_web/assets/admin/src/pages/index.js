import {get} from "svelte/store"
import {setHtmlTitle} from "../helpers/router-html-title"
import {customPageTitleUsed, pageTitle} from "../stores/page-title"
import Home from "./Home.svelte"
import Page1 from "./Page1.svelte"
import NotFound from "./NotFound.svelte"
import Error from "./Error.svelte"
import Groups from "./groups/Groups.svelte"

export const Pages = [
	{
		name: "Error",
		title: "Error",
		url: "/error",
		breadcrumb: ["Error"],
		hide: true
	},
	{
		name: "Home",
		title: "Home",
		url: "/",
		breadcrumb: ["Route 1"],
		icon: "fas fa-home",
		hide: false
	},
	{
		name: "Groups",
		title: "Groups Management",
		url: "/groups",
		breadcrumb: ["Groups"],
		icon: "fas fa-users",
		hide: false
	},
	{
		name: "NewGroup",
		title: "New Group",
		url: "/groups/new",
		breadcrumb: ["Groups", "New"],
		icon: "fas fa-plus",
		hide: false
	},
	{
		name: "GroupEdit",
		title: "Group Edit",
		url: "/groups/edit/:id",
		breadcrumb: ["Groups", "Edit"],
		icon: "fas fa-pen",
		hide: true
	}
]

export const PageUrls = Pages.reduce((acc, x) => {
	acc[x.name] = x.url
	return acc
}, {})

export function fillParams(pageUrl, params) {
	return Object
		.keys(params)
		.reduce(
			(acc, key) => acc.replace(`:${key}`, params[key]),
			pageUrl
		)
}

export function pageIsActive(location, pageName) {
	const currentMatchedPage = getPageForUrl(location)

	return currentMatchedPage?.name === pageName
}

export function getPage(name) {
	return Pages.find((o) => o.name === name)
}

export async function onRouteLoaded(route) {
	const page = Pages.find(x => x.url === route.route)

	if (!page || get(customPageTitleUsed))
		return

	pageTitle.set(typeof page.title === "function"
		? await page.title()
		: page.title
	)
}

export default {
	[PageUrls.Home]: Home,
	[PageUrls.Groups]: Groups,
	[PageUrls.NewGroup]: Groups,
	[PageUrls.GroupEdit]: Groups,
	// The catch-all route must always be last
	"*": NotFound
}
