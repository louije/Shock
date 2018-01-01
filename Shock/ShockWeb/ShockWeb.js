var ShockView = {
  init: function() {
    document.addEventListener('DOMContentLoaded', this.setup.bind(this));
  },

  setup: function () {
    this.element = document.querySelector('.ShockField');
    this.element.addEventListener('keydown', this.typed.bind(this));
      
    document.body.addEventListener("click", this.clicked.bind(this));
    document.body.addEventListener("keyup", this.escaped.bind(this));

    this.padding = this.getPadding(this.element);

    document.execCommand('insertBrOnReturn', false, true);
    document.execCommand('defaultParagraphSeparator', false, 'p')
    this.element.focus();
  },

  clicked: function(e) {
    if (e.target !== document.body && e.target.tagName !== "MAIN") {
      return;
    }
    if (this.canQuit()) {
      window.Bridge.quit(e);
    }
  },

  escaped: function(e) {
    if (e.key !== "Escape") {
      return;
    }
    e.stopPropagation();
    e.preventDefault();
    if (this.value() === "" && this.canQuit) {
      window.Bridge.quit();
    } else {
      this.clear();
    }
  },

  typed: function(e) {
    if (e.metaKey || e.shiftKey || e.ctrlKey || e.altKey || e.key === "Escape") { return; }

    window.setTimeout(this.wrap.bind(this), 0);

    this.fitAll();
  },

  wrap: function() {
    var nodes = this.element.childNodes;
    for (var i = nodes.length - 1; i >= 0; i--) {
      if (nodes[i].nodeType === 3 && nodes[i].textContent.trim() !== "") {
        var textNode = this.element.childNodes[i];
        var el = document.createElement("p");
        el.textContent = textNode.textContent;
        console.log(el.textContent);
        this.element.replaceChild(el, textNode);

        var sel = window.getSelection();
        var r = document.createRange();
        r.setStartAfter(el.childNodes[0]);
        r.setEndAfter(el.childNodes[0]);
        sel.removeAllRanges();
        sel.addRange(r);
      }
    }
  },

  fitAll: function() {
    this.hasWrapped = !!this.element.querySelector('.is-wrapped');
    (this.hasWrapped) ?
      this.element.classList.add('has-wrapped') :
      this.element.classList.remove('has-wrapped');

    var children = this.element.children;
    for (var i = children.length - 1; i >= 0; i--) {
      this.fit(children[i]);
    }
  },

  value: function() {
    return this.element.textContent.trim();
  },

  replace: function(string) {
    while (this.element.lastChild) {
        this.element.removeChild(this.element.lastChild);
    }

    if (string) {
      var p = document.createElement("p");
      p.textContent = string;
      this.element.appendChild(p);
    }

    this.fitAll();
  },

  clear: function() {
    this.replace();
  },

  set: function(string) {
    this.replace(string);
  },

  canQuit: function() {
    return window.Bridge && window.Bridge.quit;
  },

  getPadding: function(el) {
    var style = window.getComputedStyle(el, null);
    return parseInt(style.getPropertyValue('padding-left'), 10) + parseInt(style.getPropertyValue('padding-right'), 10);
  },

  round: function(size) {
    var factor = 5;
    return Math.trunc((size / factor)) * factor;
  },

  fit: function(p) {
    var low = 30;
    var high = 300;
    var mid;

    if (this.hasWrapped) {
      high = 100;
    }

    while (low <= high) {
      mid = parseInt((low + high) / 2, 10);
      p.style.fontSize = mid + 'px';

      if((p.scrollWidth) > (this.element.offsetWidth - this.padding) * 0.9) {
        high = mid - 1;
      } else {
        low = mid + 1;
      }
    }

    if (mid <= 30 && (p.scrollWidth) > (this.element.offsetWidth - this.padding) * 0.9) {
      p.classList.add("is-wrapped");
      p.style.fontSize = '';
      return;
    } else {
      p.classList.remove("is-wrapped");
    }

    var final = this.round(mid) + 'px';
    console.log(final);
    p.style.fontSize = final;
  }
}


ShockView.init();
