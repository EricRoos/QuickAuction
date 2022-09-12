import { Controller } from "@hotwired/stimulus"
/*
* TODO: export to data attrs
* - endpoint path
* - message
* - data attribute name for hidden field value
*
*/
export default class extends Controller {
  static targets = ['input', 'dataListFrame', 'hiddenField']
  connect() {
    this.inputTarget.addEventListener('keyup', ({target: { value} }) => {
      const searchParams = new URLSearchParams({query: value});
      this.dataListFrameTarget.setAttribute('src', `/game_items?${searchParams}`)
    });

    this.inputTarget.addEventListener('change', ({target: { value} }) => {
      const found = this.dataListFrameTarget.querySelector("datalist").querySelector(`[value='${value}']`) 
      if(!found){
        this.inputTarget.setCustomValidity("Invalid game item")
        return;
      }
      this.inputTarget.setCustomValidity("")
      this.hiddenFieldTarget.value = found.getAttribute("data-game-item-id");
    });
  }
}
