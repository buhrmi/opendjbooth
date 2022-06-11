<script>
  import { useForm, inertia } from '@inertiajs/inertia-svelte'
  import { onDestroy, onMount } from 'svelte';
  import consumer from '~/lib/consumer';
  import link_accounts from '~/lib/link_accounts';
  export let booth
  export let slots = []
  export let current_dj
  export let date

  let form = useForm({
    booth_id: booth.id,
    date: date,
    name: current_dj?.name,
    coords: null
  })

  $: $form.name = current_dj?.name
  $: mySlot = current_dj && slots.find(slot => slot.dj_id === current_dj.id)
  
  let sub
  onMount(function() {
    sub = consumer.subscriptions.create({ channel: "Boothhannel", id: booth.id }, {
      received(data) {
        //event = data.event
        slots = data.slots
      }
    })
  })

  onDestroy(function() {
    sub.unsubscribe()
  })

  function getPosition(options) {
    return new Promise((resolve, reject) => 
        navigator.geolocation.getCurrentPosition(resolve, reject, options)
    );
  }


  function formatTime(time) {
    time = new Date(time)
    let minutesWithLeadingZero = time.getMinutes() < 10 ? '0' + time.getMinutes() : time.getMinutes()
    return time.getHours() + ':' + minutesWithLeadingZero
  }

  let gettingPosition
  let working
  async function createSlot() {
    working = true
    $form.clearErrors()

    try {
      setTimeout(() => { if (!$form.coords) gettingPosition = true }, 500)
      const position = await getPosition()
      gettingPosition = false
      
      $form.coords = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      }
      $form.post('/slots')
      working = false
    }
    catch(e) {
      console.error(e)
      // try again
      setTimeout(createSlot, 1000)
    }
    
  }
  function formatDate(time) {
    let date = new Date(time)
    let dayNames = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
    let monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
    return dayNames[date.getDay()] + ', ' + monthNames[date.getMonth()] + ' ' + date.getDate() + ' '
  }
</script>

{#if gettingPosition}
  <div class="overlay">
    <div class="modal">
      Before adding yourself to the list, we'd like to make sure that you're actually close to the booth. Please allow location access.
    </div>
  </div>
{/if}

<div class="container">
  <h1>
    {booth.name}
  </h1>
  <div class="description">
    {formatDate(date)}
  </div>

  
  <ul class="timetable">
    {#each slots as slot}
      <li class:me={slot.dj_id == current_dj?.id}>
        <div class="time">
          {formatTime(slot.start_at)}
        </div>
        <div class="name">
          {#if slot.dj.twitter_name}
            <a target="_blank" href="https://twitter.com/{slot.dj.twitter_name}">
              {slot.dj.name}
            </a>
          {:else}
            {slot.dj.name}
          {/if}
        </div>
      </li>
    {:else}
      Timetable is empty. Be the first to take over.
    {/each}
  </ul>
</div>

<div class="bottom">
  {#if mySlot}
    <p>
      Woohoo! You're in the lineup! Your time is <b>{formatTime(mySlot.start_at)}</b>.
      {#if !current_dj?.twitter_name}
        <a on:click|preventDefault={() => link_accounts('twitter')} href="/session/new?provider=twitter">Connect your Twitter account</a>
      {/if}
    </p>
    <a class="btn" href="/slots/{mySlot.id}" use:inertia={{method: 'delete'}}>
      Remove me
    </a>
  {:else}
    <form on:submit|preventDefault={createSlot}>
      <p>
        Would you like to play?
      </p>
      <div class="row">
        <div class="field">
          <label for="name">
            Your Artist Name: 
          </label>
          <input name="name" bind:value={$form.name} />
        </div>
        {#if current_dj?.twitter_name}
          Connected to Twitter
        {:else}
          <div>or</div>
          <a on:click|preventDefault={() => link_accounts('twitter')} href="/session/new?provider=twitter">connect with Twitter</a>
        {/if}
      </div>
      {#if $form.errors.name}
        <p class="error">
          {$form.errors.name[0]}
        </p>
      {/if}
      <button name="add" class:disabled={working} class="btn">
        Add me to the lineup
      </button>

  </form>
  {/if}
</div>

<style>
  .overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0,0,0,0.5);
    z-index: 10;
  }
  .description {
    font-size: 1.3em;
    color:rgba(48, 52, 78, 0.692);
  }
  .modal {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    min-width: 300px;
    background: white;
    padding: 1rem;
    border-radius: 0.5rem;
    text-align: center;
  }
  .timetable li {
    margin: 12px 0;
    padding: 12px;
    border: 1px solid #eee;
  }
  .timetable .name {
    font-weight: bold;
    font-size: 1.2em;
  }
  .timetable .me {
    background-color: rgb(255, 254, 203);
  }
  .bottom {
    position: absolute;
    bottom: 0;
    width: 100%;
    background: #fff;
    padding: 18px;
    box-shadow: 0 -1px 3px #e0e0e0;
  }
  .row {
    display: flex;
    /* justify-content: space-between; */
    align-items: center;
    margin-bottom: 12px;
    gap: 8px;
  }
  p {
    margin-bottom: 12px;
  }
  input {
    flex: 1;
    padding: 6px;
    width: 100%;
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
  .btn.disabled {
    opacity: 0.5;
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