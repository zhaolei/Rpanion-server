const assert = require('assert')
const settings = require('settings-store')
const VideoStream = require('./videostream')
const winston = require('./winstonconfig')(module)

describe('Video Functions', function () {
  it('#videomanagerinit()', function () {
    const vManager = new VideoStream(settings, winston)

    // check initial status
    assert.equal(vManager.active, false)
  })

  it('#videomanagerpopulateaddresses()', function () {
    // Getting a list of valid IP addresses
    const vManager = new VideoStream(settings, winston)

    vManager.populateAddresses()

    // check initial status
    assert.notEqual(vManager.ifaces.length, 0)
    assert.notEqual(vManager.deviceAddresses.length, 0)
  })

  it('#videomanagerscan()', function (done) {
    // Scanning for video devices capable of streaming
    // in a CI environment, no devices will be returned
    const vManager = new VideoStream(settings, winston)

    vManager.populateAddresses()
    vManager.getVideoDevices(function (err, devices, active, seldevice, selRes, selRot, selbitrate, selfps, SeluseUDP, SeluseUDPIP, SeluseUDPPort) {
      assert.equal(err, null)
      assert.equal(active, false)
      assert.equal(seldevice, null)
      assert.equal(selRes, null)
      assert.equal(selRot, null)
      assert.equal(selbitrate, null)
      assert.equal(selfps, null)
      assert.equal(SeluseUDP, false)
      assert.equal(SeluseUDPIP, '127.0.0.1')
      assert.equal(SeluseUDPPort, 5400)
      done()
    })
  }).timeout(5000)
})
