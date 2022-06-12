<script>
  export let upcoming
  export let past
  import login from '~/lib/link_accounts'
  import { inertia } from '@inertiajs/inertia-svelte'

</script>

<div class="container">

  <h1>Open DJ Booth</h1>

  <h2>How to participate</h2>

  <ol>
    <li>
      1. Download <a href="https://rekordbox.com/download/" target="_blank">Rekordbox</a> and prepare a DJ set
    </li>
    <li>
      2. <a href="/session/new?provider=twitter" on:click|preventDefault={login}>Connect your Twitter account</a> (other socials coming soon)
    </li>
    <li>
      3. Come to an upcoming event
    </li>
    <li>
      4. Add yourself to the lineup
    </li>
  </ol>

  <h2>Upcoming Events</h2>

  {#each upcoming as event}
    {new Date(event.start_at).toLocaleString()}: 
    <a href="/events/{event.id}" use:inertia>{event.name}</a>
  {:else}
    Nothing planned. Check back later or follow us on <a target="_blank" href="https://twitter.com/opendjbooth">Twitter</a>.
  {/each}

</div>

<style>
  h1 {
    font-size: 2em;
    margin-bottom: 0.5em;
  }
  h2 {
    font-size: 1.5em;
    margin: 1.0em 0 0.5em;
  }
</style>