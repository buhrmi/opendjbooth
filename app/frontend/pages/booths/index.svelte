<script>
  export let booths
  import { inertia } from '@inertiajs/inertia-svelte'

</script>

<div class="container">

  <h1>Open DJ Booth</h1>

  <h2>How to participate</h2>

  <ol>
    <li>
      1. Prepare your USB stick with Rekordbox
    </li>
    <li>
      2. Find a DJ booth
    </li>
    <li>
      3. Add yourself to the lineup
    </li>
    <li>
      4. Join us on <a href="https://twitch.tv/opendjbooth" target="_blank">Twitch</a>
    </li>
  </ol>

  <h2>All DJ Booths</h2>

  {#each booths as booth}
    <a href="/booths/{booth.id}" use:inertia>{booth.name}</a>
  {/each}
</div>