/* eslint-disable */
const each_func = (list, callback) => {
  list.forEach((elem, i) => {
    let fn = callback.bind(elem);
    fn(elem, i)
  });
};
const events_funcs = (list, event_name, handler) => {
  list.forEach(elem => {
    elem.addEventListener(event_name, handler)
  })
};
const css_func = (list, args) => {
  switch (typeof args[0]) {
    case "string":
      const [property, value] = args;
      list.forEach(el => {
        el.style[property] = value;
      });
      break;
    case "object":
      list.forEach(el => {
        Object.entries(args[0]).forEach(([property, value]) => {
          el.style[property] = value;
        });
      })
  }
};
const work_with_list = (list) => {
  list.on = (en, h) => events_funcs(list, en, h);
  list.val = () => list[0].value;
  list.put = (val) => list[0].value = val;
  list.each = (cb) => each_func(list, cb);
  list.css = (...args) => css_func(list, args);
};

const $ = (...args) => {
  const a0 = args[0];
  
  switch (typeof a0) {
    case "function":
      document.addEventListener('DOMContentLoaded', a0)
      break;
    case "string":
      const list = document.querySelectorAll(a0);
      work_with_list(list)
      return list;
    case "object" && a0 instanceof HTMLElement:
      const elements = [a0];
      work_with_list(elements)
      return elements;
    default: 
      return null;
  }
};