<script lang="ts">
	import Panel from '$components/panel.svelte';
	import { BookOpenIcon, ToolIcon, UserIcon, UsersIcon, ZapIcon } from 'svelte-feather-icons';
	import { onMount } from 'svelte';
	import { Environment } from '$lib/Common';
	import { fade, blur, fly, slide, scale, crossfade } from 'svelte/transition';

	onMount(() => {
		if (Environment.firstLoadMainPage) {
			setTimeout(() => {
				loaded = true;
				Environment.firstLoadMainPage = false;
			}, 550);
		} else {
			loaded = true;
		}
	});

	$: loaded = false;
</script>

<div class="flex flex-col">
</div>
