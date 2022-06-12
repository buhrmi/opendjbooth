<script>
  import { onMount } from 'svelte'
  import '~/lib/twitch'

  onMount(function() {
    new Twitch.Embed("twitch-embed", {
      channel: "opendjbooth"
    })
  })
</script>

<div id="twitch-embed" class="relative flex-1" />