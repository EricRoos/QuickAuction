import { Controller } from "@hotwired/stimulus"
import { useDebounce } from 'stimulus-use'
/*
* TODO: export to data attrs
* - endpoint path
* - message
* - data attribute name for hidden field value
*
*/
export default class extends Controller {
  static targets = ['input', 'dataListFrame', 'hiddenField']
  static debounces = ['setFrameSrc']

  connect() {
    useDebounce(this);

    this.inputTarget.addEventListener('keyup', ({target: { value} }) => {
      this.setFrameSrc(value, {wait: 500 });
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

  setFrameSrc(queryValue){
    const searchParams = new URLSearchParams({query: queryValue});
    this.dataListFrameTarget.setAttribute('src', `/game_items?${searchParams}`)
  }
}
