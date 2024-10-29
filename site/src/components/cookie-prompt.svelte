<script lang="ts">
	import * as m from '$lib/paraglide/messages.js';

    export let accept: () => void;
    export let settings: () => void;
</script>

<div class="p-6 text-center">
	<h3 class="text-3xl font-semibold sm:text-4xl">{m.value_privacy()}</h3>
	<hr class="h-0.25 mt-2 bg-black dark:bg-white border-transparent rounded-lg" />
	<p class="mt-2">
		{m.site_uses_cookies()}
	</p>
	<p>{m.accept_cookies_msg()}</p>
	<div class="mt-4">
		<button
            on:click={() => accept()}
			type="submit"
			class="inline-flex px-4 mr-1 py-2 font-medium rounded-lg duration-150 hover:shadow-md hover:bg-main disabled:bg-transparent transition-colors disabled:cursor-not-allowed"
		>
			{m.accept_cookies()}
		</button>
		<button
            on:click={() => settings()}
			type="submit"
			class="inline-flex px-4 ml-1 py-2 font-medium rounded-lg duration-150 hover:shadow-md hover:bg-main disabled:bg-transparent transition-colors disabled:cursor-not-allowed"
		>
			{m.cookie_settings_emoji()}
		</button>
	</div>
</div>
