<script>
  import { onMount } from 'svelte'
  import '~/lib/twitch'

  onMount(function() {
    new Twitch.Embed("twitch-embed", {
      channel: "opendjbooth"
    })
  })
</script>

<header>
  
  <h1>Open DJ Booth</h1>
  <nav>
    Live on Twitch.
  </nav>

</header>

<div id="twitch-embed" class="relative flex-1">
  
</div>

<style>
  header {
    background: #000;
    color: #fff;
    padding: 1rem;
  }
</style>