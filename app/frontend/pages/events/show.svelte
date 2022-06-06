<script>
  import { useForm, inertia } from '@inertiajs/inertia-svelte'
  import { onMount } from 'svelte';
  import consumer from '~/lib/consumer';
  export let event
  export let slots = []
  export let current_dj

  $: mySlot = slots.find(slot => slot.dj_id === current_dj.id)
  
  onMount(function() {
    consumer.subscriptions.create({ channel: "EventChannel", id: event.id }, {
      received(data) {
        //event = data.event
        slots = data.slots
      }
    })
  })

  let form = useForm('slot', {
    event_id: event.id,
    name: null
  })

  function createSlot() {
    $form.post('/slots')
  }
</script>

<div class="container">
  <h1>
    {event.name}
  </h1>


  
  <ul>
    {#each slots as slot}
      <li>
        {slot.dj.name}
      </li>
    {:else}
      Timetable is empty. Be the first to take over.
    {/each}
  </ul>
</div>

<div class="bottom">
  {#if mySlot}
    <p>
      Woohoo! You're on the list!
    </p>
    <a class="btn" href="/slots/{mySlot.id}" use:inertia={{method: 'delete'}}>
      Remove me
    </a>
  {:else}
    <form on:submit|preventDefault={createSlot}>
      <p>
        Would you like to play?
      </p>
      <div class="field">
        <label for="name">
          Your DJ Name: 
        </label>
        <input bind:value={$form.name} />
      </div>
      {#if $form.errors.name}
        <p class="error">
          
            {$form.errors.name[0]}
          
        </p>
      {/if}
      <button class="btn ">
        Add me to the list
      </button>

  </form>
  {/if}
</div>

<style>
  .bottom {
    position: absolute;
    bottom: 0;
    width: 100%;
    background: #fff;
    padding: 12px;
    box-shadow: 0 -1px 3px #e0e0e0;
  }
  .field {
    display: flex;
    justify-content: space-between;
    align-items: baseline;
    margin-bottom: 12px;
    gap: 12px;
  }
  p {
    margin-bottom: 12px;
  }
  .field input {
    flex: 1;
    padding: 6px;
  }
  .btn {
    align-items: center;
    appearance: none;
    background-image: radial-gradient(100% 100% at 100% 0, #5adaff 0, #5468ff 100%);
    border: 0;
    border-radius: 6px;
    box-shadow: rgba(45, 35, 66, .4) 0 2px 4px,rgba(45, 35, 66, .3) 0 7px 13px -3px,rgba(58, 65, 111, .5) 0 -3px 0 inset;
    box-sizing: border-box;
    color: #fff;
    cursor: pointer;
    display: inline-flex;
    height: 48px;
    justify-content: center;
    line-height: 1;
    list-style: none;
    overflow: hidden;
    padding-left: 16px;
    padding-right: 16px;
    position: relative;
    text-decoration: none;
    transition: box-shadow .15s,transform .15s;
    user-select: none;
    -webkit-user-select: none;
    touch-action: manipulation;
    white-space: nowrap;
    will-change: box-shadow,transform;
    font-size: 18px;
    width: 100%;
  }

  .btn:focus {
    box-shadow: #3c4fe0 0 0 0 1.5px inset, rgba(45, 35, 66, .4) 0 2px 4px, rgba(45, 35, 66, .3) 0 7px 13px -3px, #3c4fe0 0 -3px 0 inset;
  }

  .btn:hover {
    box-shadow: rgba(45, 35, 66, .4) 0 4px 8px, rgba(45, 35, 66, .3) 0 7px 13px -3px, #3c4fe0 0 -3px 0 inset;
    transform: translateY(-2px);
  }

  .btn:active {
    box-shadow: #3c4fe0 0 3px 7px inset;
    transform: translateY(2px);
  }
</style>