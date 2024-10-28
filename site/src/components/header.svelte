<script lang="ts">
	import { fade, slide } from 'svelte/transition';
	import { get } from 'svelte/store';

	import { Environment } from '$lib/Common';

	import { onMount } from 'svelte';

	const darkMode = Environment.darkMode;

	function toggleTheme(): void {
		Environment.setTheme(!get(darkMode));
	}

	onMount(() => {
		Environment.setTheme(get(darkMode));
	});
</script>

<header>

</header>

<style>
	
</style>
