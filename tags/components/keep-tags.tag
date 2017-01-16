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
