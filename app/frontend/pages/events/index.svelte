<script>
  export let upcoming
  export let past
  import { inertia } from '@inertiajs/inertia-svelte'

</script>

<div class="container">

  <h1>Open DJ Place</h1>

  <h2>How to participate</h2>

  <ol>
    <li>
      1. Prepare your USB stick with Rekordbox
    </li>
    <li>
      2. Find an upcoming event
    </li>
    <li>
      3. Show up and add yourself to the lineup
    </li>
    <li>
      4. Join us on <a href="https://twitch.tv/opendjplace" target="_blank">Twitch</a>
    </li>
  </ol>

  <h2>Upcoming Events</h2>

  {#each upcoming as event}
    {new Date(event.start_at).toLocaleString()}: 
    <a href="/events/{event.id}" use:inertia>{event.name}</a>
  {:else}
    Nothing planned. Check back later or follow us on <a target="_blank" href="https://twitter.com/opendjplace">Twitter</a>.
  {/each}

</div>