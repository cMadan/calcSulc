# calcSulc
## sulcal depth

##### (lower priority)

1. load pial surface, parcel annot, sulcal map, gyrif surface
1. isolate faces associated with desired parcel
1. find vertices for lowest points in map, using sulcal map
  * lowest *10%* of sulc for that sulci
1. calculate distance between vertex on pial surface and gyrif surface vertex

#### alternate estimation approach
- measure distance from vertex, normal to mesh, until collides with gyrif surface
- is it better for it to be normal to mesh, or just nearest?
