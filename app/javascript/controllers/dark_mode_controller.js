import { Controller } from "@hotwired/stimulus"
import Cookies from 'js-cookie'

export default class extends Controller {
  connect() {
    console.log('dark mode connect');
  }

  toggle(ev){
    ev.preventDefault();
    let htmlClasses = document.children[0].classList;
    if(htmlClasses.contains('dark')){
      htmlClasses.remove('dark');
      Cookies.set('darkMode', '')
    }else{
      htmlClasses.add('dark');
      Cookies.set('darkMode', 'dark')
    }
  }
}
