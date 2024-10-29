<script lang="ts">
	import { CookieSettingsManager } from "$lib/CookieSettingsManager";
	import * as m from '$lib/paraglide/messages.js';

	export let onSave: (settings: { analytics: boolean }) => void;
    const initialPreferences = CookieSettingsManager.getPreferences();
	let analyticsEnabled = initialPreferences.analytics;

	const handleSave = () => {
		onSave({ analytics: analyticsEnabled });
	};
</script>

<div class="p-6 text-center">
	<h3 class="text-3xl font-semibold sm:text-4xl">{m.cookie_settings_emoji()}</h3>
	<hr class="h-0.25 mt-2 bg-black dark:bg-white border-transparent rounded-lg" />

	<div class="mt-4">
		<div class="flex justify-between">
			<label for="required" class="text-lg">{m.required()}</label>
			<button
				type="button"
				class="relative w-12 h-6 rounded-full transition-colors duration-300 focus:outline-none focus:ring-2 focus:ring-main bg-main opacity-50"
				role="switch"
				aria-checked={true}
				aria-labelledby="required"
                disabled={true}
			>
				<span
					class="absolute left-0 top-0 w-6 h-6 bg-white rounded-full transition-transform duration-300 transform translate-x-6"
				></span>
			</button>
		</div>
		<p class="text-xs text-left mt-2">
			{m.minimal_cookies()}
		</p>
	</div>

	<div class="mt-4">
		<div class="flex justify-between">
			<label for="analytics" class="text-lg">{m.google_analytics()}</label>
			<button
				type="button"
				class="relative w-12 h-6 rounded-full transition-colors duration-300 {analyticsEnabled
						? 'bg-main'
						: 'ring-2 ring-main'}"
				role="switch"
				aria-checked={analyticsEnabled}
				aria-labelledby="analytics"
				on:click={() => (analyticsEnabled = !analyticsEnabled)}
			>
				<span
					class="absolute left-0 top-0 w-6 h-6 bg-white rounded-full transition-transform duration-300 transform {analyticsEnabled
						? 'translate-x-6'
						: 'translate-x-0'}"
				></span>
			</button>
		</div>
		<p class="text-xs text-left mt-2">
			{m.anonymouse_data_cookies()}
		</p>
	</div>

	<div class="mt-6">
		<button
			on:click={handleSave}
			type="button"
			class="inline-flex px-4 py-2 font-medium rounded-lg duration-150 hover:shadow-md hover:bg-main disabled:bg-transparent transition-colors disabled:cursor-not-allowed"
		>
			{m.save_settings()}
		</button>
	</div>
</div>
