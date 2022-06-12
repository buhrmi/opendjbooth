<script>
  import { inertia } from '@inertiajs/inertia-svelte'
  export let flash
</script>

<nav>
  <a use:inertia href="/">
    <img class="logo" src="~/images/logo.png" alt="Open DJ Booth">
  </a> 
</nav>

{#if flash.error}
  <div class="flash error">
    {flash.error}
  </div>
{/if}

<slot />

<style>

  nav li a {
    background-color: blueviolet;
    padding: 8px 18px;
    color: white;
    border-radius: 8px;
  }
  nav {
    padding: 12px;
    justify-content: space-between;
    display: flex;
    align-items: center;
    background-color: black;
  }
  .logo {
    height: 45px;
  }

</style>