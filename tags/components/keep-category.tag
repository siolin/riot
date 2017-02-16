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
