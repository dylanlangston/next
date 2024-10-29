<script lang="ts">
	import { MailIcon, LinkedinIcon, GithubIcon } from 'svelte-feather-icons';
	import Ripple from '$components/ripple.svelte';
	import * as m from '$lib/paraglide/messages.js';

	export let openCookieSettings: () => void;
</script>

<footer class="p-1 px-4 md:px-8">
	<div class="container mx-auto md:space-y-12">
		<div class="grid justify-center lg:justify-between">
			<div class="static flex justify-center lg:col-start-1">
				<div class="select-none inline-block static my-1 lg:mr-10 md:mr-1 self-center">
					<Ripple escapeParent={true}>
						<button
							class="flex items-center justify-center w-10 h-10 rounded-full hover:shadow-md hover:bg-main transition-colors duration-300"
							title={m.cookie_settings()}
							on:click={openCookieSettings}
						>
							🍪
						</button>
					</Ripple>
				</div>
			</div>
			<div
				class="static flex flex-col self-center text-sm text-center md:block lg:row-end-1 lg:col-end-1"
			>
				<span><a href="https://raylib.com/">{m.made_with_raylib()}</a></span>
			</div>
		</div>
	</div>
</footer>
