import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.tick();
    setInterval(this.tick.bind(this), 1000);
  }

  tick(){
    let current_time = parseInt(this.element.getAttribute('data-expires-on')) * 1000;
    let diff = current_time - new Date();
    if(diff <= 0){
      this.element.innerHTML = 'Auction has expired'
      return;
    }
    var d = Number(diff) / 1000;
    var h = Math.floor(d / 3600);
    var m = Math.floor(d % 3600 / 60);
    var s = Math.floor(d % 3600 % 60);

    var hDisplay = h > 0 ? h + (h == 1 ? " hour, " : " hours, ") : "";
    var mDisplay = m > 0 ? m + (m == 1 ? " minute, " : " minutes, ") : "";
    var sDisplay = s > 0 ? s + (s == 1 ? " second" : " seconds") : "";
    var out = hDisplay + mDisplay + sDisplay; 
    this.element.innerHTML = out;
  }
}
