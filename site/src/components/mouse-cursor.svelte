<script lang="ts">
	import { Environment, useMediaQuery } from '$lib/Common';
	import { spring } from 'svelte/motion';
	import { readable, writable, get } from 'svelte/store';
	import { onMount } from 'svelte';
	import { MousePointerIcon } from 'svelte-feather-icons';

	let coords1 = spring(
		{ x: 0, y: 0 },
		{
			stiffness: 0.05,
			damping: 0.2
		}
	);

	let coords2 = spring(
		{ x: 0, y: 0 },
		{
			stiffness: 0.1,
			damping: 0.35
		}
	);

	let size = spring(10, {
		stiffness: 0.05,
		damping: 0.35
	});

	let visible: boolean = false;

	let loaded: boolean = false;

	function debounce(cb: Function, t: number) {
		let timer: NodeJS.Timeout;
		return (...args: any[]) => {
			clearTimeout(timer);
			timer = setTimeout(() => cb(...args), t);
		};
	}

	const hideAfterOneSecond = debounce(() => {
		if (get(size) == 10) {
			size.set(0);
		}
	}, 1000);

	onMount(() => (loaded = true));
</script>

<svelte:body
	on:mouseout={(e) => {
		if (
			e.clientY <= 0 ||
			e.clientX <= 0 ||
			e.clientX >= window.innerWidth ||
			e.clientY >= window.innerHeight
		) {
			visible = false;
			size.set(0, { hard: true });
		}
	}}
	on:mousemove|capture|nonpassive={(e) => {
		coords1.set({ x: e.clientX, y: e.clientY }, { hard: !visible });
		coords2.set({ x: e.clientX, y: e.clientY }, { hard: !visible });
		if (!visible) {
			size.set(0, { hard: true });
		} else if (get(size) == 0) {
			size.set(10);
		}
		visible = getComputedStyle(e.target as Element).cursor == 'none';
		hideAfterOneSecond();
	}}
	on:mousedown|capture|passive={(e) => {
		if (visible) size.set(30);
	}}
	on:mouseup|capture|passive={(e) => {
		if (visible) size.set(10);
		hideAfterOneSecond();
	}}
/>
<svg class="absolute top-0 left-0 w-screen h-screen pointer-events-none transition">
	{#if $size > 0}
		<circle
			cx={$coords1.x - 2 + $size}
			cy={$coords1.y - 2 + $size}
			r={$size * 2}
			class="stroke-main"
			stroke-width={$size / 3}
			fill-opacity="0"
		/>
		<svg x={$coords2.x - 2} y={$coords2.y - 2}>
			<MousePointerIcon class="stroke-white/[.5] dark:stroke-black/[.5] fill-black dark:fill-white" size={`${($size * 2)}`}></MousePointerIcon>
		</svg>
	{/if}
</svg>
