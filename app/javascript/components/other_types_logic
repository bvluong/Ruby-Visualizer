case typeof this.stack[v] === 'string':
  if (this.stack[v].slice(this.stack[v].length-3) === 'SYM') {
    localOtherTypes.push({v: this.stack[v]})
  } else {
    localOtherTypes.push({v: this.stack[v]})
  }
  break;
case typeof this.stack[v] === 'number':
  if (this.stack[v] % 1 === 0) {
    localOtherTypes.push({v: this.stack[v]})
  } else {
    vals.push(`${this.stack[v]}`)
    types.push('float')
    currVars.push(v)
    // cols.push(`[${v}], [${this.stack[v]}], ['FLOAT']`)
  }
  break;
case typeof this.stack[v] === 'boolean':
  vals.push(`${this.stack[v]}`)
  types.push('boolean')
  currVars.push(v)
  // cols.push(`[${v}], [${this.stack[v]}], ['BOOLEAN']`)
