let when = (desc, fn) => describe('when ' + desc, fn)
let fwhen = (desc, fn) => fdescribe('when ' + desc, fn)
let xwhen = (desc, fn) => xdescribe('when ' + desc, fn)

let and = (desc, fn) => describe('and ' + desc, fn)
let fand = (desc, fn) => fdescribe('and ' + desc, fn)
let xand = (desc, fn) => xdescribe('and ' + desc, fn)