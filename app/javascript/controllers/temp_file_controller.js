import { Controller } from "@hotwired/stimulus"

function urltoFile(url, filename, mimeType){
  return (fetch(url)
      .then(function(res){return res.arrayBuffer();})
      .then(function(buf){return new File([buf], filename,{type:mimeType});})
  );
}

export default class extends Controller {
  connect() {
    urltoFile(localStorage.getItem('tmp_auction_image'), 'file.png', 'image/png').then( (file) => {
      console.log(file);
      const dt = new DataTransfer();
      dt.items.add(file)
      this.element.files = dt.files;
    });

    this.element.addEventListener('change', (ev) => {
      var reader = new FileReader();
      reader.onload = () => {
        localStorage.setItem('tmp_auction_image',reader.result);
      }
      reader.readAsDataURL(ev.target.files[0])
    })
  }
}
