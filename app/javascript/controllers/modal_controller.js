import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Hello, Stimulus!", this.element);
  }

  open({params}){
    const modal = this.modalElement()
    const turboFrame = modal.querySelector('turbo-frame');
    turboFrame.setAttribute('src', params.contentSource);
    modal.classList.remove('hidden')
  }

  close({}){
    this.modalElement().classList.add('hidden')
  }

  modalElement(){
    return document.querySelector("[aria-modal]");
  }
  
}
