<keep>

  <div class="keep" style="background-color: {color}">

    <form class="add-form" action="" onsubmit="{addKeep}">
      <label for="keep" style="display: none;">Keep</label>

      <!-- Keep field -->
      <input
        name="keep"
        class="text-field"
        type="text"
        id="keep"
        placeholder="Keep"
        if={opts.form || editKeepShow}>

      <!-- Text of keep -->
      <div
        class="keep-name"
        if={opts.list && !editKeepShow}>{item.title}</div>

      <!-- Tag list -->
      <div class="tags">
        <div each={tagList}>
          <div class="tag" if={select}>{title}</div>
        </div>
      </div>

      <!-- Category list -->
      <div class="category">
        <div each={categoryList}>
          <div class="category" if={select}>{title}</div>
        </div>
      </div>

      <!-- Options of keep -->
      <div class="keep-options" if={opts.form || editKeepShow}>
        <i class="color-link fa fa-paint-brush" onclick="{showModal}" data-modal="pallet"></i>
        <div if={modals.pallet} onmouseleave="{showModal}" data-modal="pallet">
          <keep-color />
        </div>

        <i class="action-link fa fa-ellipsis-v" onclick="{showModal}" data-modal="actions"></i>
        <div if={modals.actions} onmouseleave="{showModal}" data-modal="actions">
          <div class="action-list">
            <ul class="list">
              <li class="item"><a onclick={showModal} data-modal="tags">Добавить ярлык</a></li>
              <li class="item"><a onclick={showModal} data-modal="category">Добавить категорию</a></li>
            </ul>
          </div>
        </div>
        <div if={modals.tags} data-modal="tags" onmouseleave="{showModal}">
          <keep-tags />
        </div>
        <div if={modals.category} data-modal="category" onmouseleave="{showModal}">
          <keep-category />
        </div>

      </div>

    </form>

    <i class="edit-btn fa fa-pencil-square-o" aria-hidden="true" if={opts.list} onclick="{editKeep}"></i>

  </div>


  <script>

    var vm = this;

    this.tagList = [];
    this.categoryList = [];
    this.color = 'white';
    this.editKeepShow = false;

    // Set keep text
    if (this.opts.form) {
      this.keep.value = '';
    } else if (this.opts.list) {
      this.item = this.opts.item;
      this.keep.value = this.item.title;
      this.tagList = this.item.tagList;
      this.categoryList = this.item.categoryList;
      this.color = this.item.color;
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
      vm.parent.update();
    }

    // Show keep options
    this.editKeep = function(e) {
      e.preventDefault();
      vm.editKeepShow = !vm.editKeepShow;
      vm.update();
      console.log(vm);
    }

  </script>

</keep>
