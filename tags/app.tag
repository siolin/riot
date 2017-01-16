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
