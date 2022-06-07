<script>
  export let flash
</script>

{#if flash.error}
  <div class="flash error">
    {flash.error}
  </div>
{/if}

<slot />