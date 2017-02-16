<keep-color>

  <div class="color-block">

    <div class="pallet-block">
      <button
      type="button"
      class="pallet-btn"
      each={color in palletColor}
      style="background-color: {color}"
      onclick="{setColor}"
      data-modal="pallet">{color}</button>
    </div>

  </div>


  <script>

    var vm = this;

    this.palletColor = [ "#F44336", "#E91E63", "#9C27B0", "#673AB7", "#3F51B5", "#009688", "white" ];

    this.setColor = function(e) {
      vm.parent.color = e.target.innerText;
      vm.parent.showModal(e);
    }

  </script>

</keep-color>
