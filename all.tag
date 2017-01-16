<app>

  <!--<keep-form></keep-form>-->

  <header>

    <keep form={true} list={false}></keep>

  </header>

  <main>

    <div each={item in keep} class="keep-wrapper">
      <keep form={false} list={true} item={item}></keep>
    </div>

  </main>

  <script>

    this.keep = [];

  </script>

</app>

<keep-color class="color-block">

  <div class="pallet-block">
    <button
      type="button"
      class="pallet-btn"
      each={color in palletColor}
      style="background-color: {color}"
      onclick="{setColor}"
      data-modal="pallet">{color}</button>
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

<keep-tags class="keep-tags">

  <div class="tag-block">

    <form action="" onsubmit={addTag}>

      <input type="text" name="tag" placeholder="Tag" autocomplete="off">

      <span style="color: lightcoral; font-size: .8rem">{this.message}</span>

      <ul class="tag-list">
        <li class="tag-item" each={tagList}>
          <input type="checkbox" checked={select} id="select-{title}" onchange="{changeCheckbox}">
          <label for="select-{title}">{title}</label>
        </li>
      </ul>

    </form>

  </div>

  <script>

    var vm = this;

    this.tagList = [
      {
        title: 'low',
        select: false
      },
      {
        title: 'medium',
        select: false
      },
    ];

    this.parent.tagList = this.tagList;

    this.addTag = function(e) {

      e.preventDefault();
      var value = vm.tag.value.toLowerCase().trim();

      var tag = {
        title: value,
        select: false
      };

      var checked = vm.tagList.some(function(el){
        return el.title === value;
      }, vm);

      if (!checked) {
        if (value) {
          vm.tagList.unshift(tag);
          vm.message = '';
        }
      } else {
        vm.message = "Такой ярлык уже существует!";
      }
      vm.tag.value = '';
    }

    this.changeCheckbox = function(e) {
      this._item.select = !this._item.select;
      vm.parent.update();
    }

  </script>

</keep-tags>

<keep class="keep">

  <form class="add-form" action="" style="background-color: {color}" onsubmit="{addKeep}">
    <label for="keep" style="display: none;">Keep</label>

    <!-- Keep field -->
    <input
      name="keep"
      class="text-field"
      type="text"
      id="keep"
      placeholder="Keep"
      if={opts.form}>

    <!-- Text of keep -->
    <div
      class="keep-name"
      if={opts.list}>{item.title}</div>

    <!-- Tag list -->
    <div class="tags">
      <div each={tagList}>
        <div class="tag" if={select}>{title}</div>
      </div>
    </div>

    <!-- Options of keep -->
    <div class="keep-options">
      <i class="color-link fa fa-paint-brush" onmouseover="{showModal}" data-modal="pallet"></i>
      <div if={modals.pallet} onmouseleave="{showModal}" data-modal="pallet">
        <keep-color />
      </div>

      <i class="action-link fa fa-ellipsis-v" onmouseover="{showModal}" data-modal="actions"></i>
      <div if={modals.actions} onmouseleave="{showModal}" data-modal="actions">
        <div class="action-list">
          <ul class="list">
            <li class="item"><a onclick={showModal} data-modal="tags">Добавить ярлык</a></li>
            <li class="item"><a onclick={showModal} data-modal="category">Добавить категорию</a></li>
          </ul>
        </div>
      </div>
      <div class="keep-tags" if={modals.tags} data-modal="tags" onmouseleave="{showModal}">
        <keep-tags />
      </div>
    </div>

  </form>

  <script>

    var vm = this;

    this.tagList = [];
    this.color = 'white';

    // Set keep text
    if (this.opts.form) {
      this.keep.value = '';
    } else if (this.opts.list) {
      this.item = this.opts.item;
    }

    // Modals
    this.modals = {
      pallet: false,
      actions: false,
      tags: false,
      category: false
    };

    // ResetM modals
    this.resetModals = function() {
      for (prop in this.modals) {
        this.modals[prop] = false;
      }
    };

    // Check if open opened modal
    this.checkModal = function(modal) {
      for (prop in this.modals) {
        if (prop == modal && this.modals[prop] == true) {
          return true;
        }
      }
    };

    // Show modal
    this.showModal = function(e) {
      if (this.checkModal(e.target.dataset.modal)) {
        this.modals[e.target.dataset.modal] = false;
      } else {
        this.resetModals();
        this.modals[e.target.dataset.modal] = true;
      }
      this.update();
    };

    // Add keep
    this.addKeep = function(e) {
      e.preventDefault();
      vm.parent.keep.push({
        title: vm.keep.value,
        color: vm.color,
        tagList: vm.tagList
      });
      vm.keep.value = '';
      console.log(vm.parent);
      vm.parent.update();
    }

  </script>

</keep>
