// @uppy/utils/lib/emaFilter@6.1.1 downloaded from https://ga.jspm.io/npm:@uppy/utils@6.1.1/lib/emaFilter.js

/**
 * Low-pass filter using Exponential Moving Averages (aka exponential smoothing)
 * Filters a sequence of values by updating the mixing the previous output value
 * with the new input using the exponential window function
 *
 * @param newValue the n-th value of the sequence
 * @param previousSmoothedValue the exponential average of the first n-1 values
 * @param halfLife value of `dt` to move the smoothed value halfway between `previousFilteredValue` and `newValue`
 * @param dt time elapsed between adding the (n-1)th and the n-th values
 * @returns the exponential average of the first n values
 */
function emaFilter(e,t,r,a){return r===0||e===t?e:a===0?t:e+(t-e)*2**(-a/r)}export{emaFilter as default};

