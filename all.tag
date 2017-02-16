<app>

  <header class="main-header">

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

<keep-category>

  <div class="category-block">

    <form class="category-form" action="" onsubmit={addCategory}>

      <div class="bread-crumbs">
        <span class="category-title" each={categoryTitle}>{title}</span>
      </div>

      <input type="text" name="category" placeholder="Category" autocomplete="off">

      <span style="color: lightcoral; font-size: .8rem">{this.message}</span>

      <ul class="category-list">
        <li class="category-item" each={showedCategoryList}>
          <input type="checkbox" checked={select} onchange="{changeCategory}">
          <label class="category-title" onclick="{showChildCategories}" data-id={id}>{title}&nbsp;<span class="children-length">({children.length})</span></label>
        </li>
      </ul>

    </form>

  </div>


  <script>

    var vm = this;

    this.categoryList = [
      {
        id: 1,
        title: "Cars",
        select: false,
        children: [
          {
            id: 4,
            title: "Mercedes",
            select: false,
            children: []
          },
          {
            id: 5,
            title: "BMW",
            select: false,
            children: []
          }
        ]
      },
      {
        id: 2,
        title: "Hotels",
        select: false,
        children: [
          {
            id: 6,
            title: "The Plaza Hotel",
            select: false,
            children: []
          }
        ]
      },
      {
        id: 3,
        title: "Countries",
        select: false,
        children: [
          {
            id: 7,
            title: "USA",
            select: false,
            children: []
          },
          {
            id: 8,
            title: "Ukrainian",
            select: false,
            children: [
              {
                id: 9,
                title: "Kiev",
                select: false,
                children: []
              }
            ]
          }
        ]
      }
    ];

    this.currentCategoryId = '0';

    this.showList = function( array, id ) {
      if (id === 0) {
        this.showedCategoryList = array;
        return;
      }
      return array.forEach(function(el) {
        if ( id == el.id ) {
          this.showedCategoryList = el.children;
          console.log(this);
        } else {
          this.showList( el.children, id );
        }
      }, this);
    }

    this.showList(this.categoryList, 0);

    this.categoryTitle = [];

    this.showChildCategories = function(e) {
      this.parent.showList(this.categoryList, e.target.dataset.id);
      this.parent.update();
    };

    this.addCategory = function() {
      console.log('add category');
    };

    this.changeCategory = function(e) {
      this._item.select = !this._item.select;
      vm.parent.update();
    }


  </script>

</keep-category>

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

<keep-tags>

  <div class="tag-block">

    <form class="tag-form" action="" onsubmit={addTag}>

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
