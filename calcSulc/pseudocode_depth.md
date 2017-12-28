# calcSulc
## sulcal depth

##### (lower priority)

1. load pial surface, parcel annot, sulcal map, gyrif surface
1. isolate faces associated with desired parcel
1. calculate distance between vertex on pial surface and *same vertex* on gyrif surface vertex

#### no need to be only the deepest part of the sulci, right?
- find vertices for lowest point in map, using sulcal map

#### alternate estimation approach
- measure distance from vertex, normal to mesh, until collides with gyrif surface
- is it better for it to be normal to mesh, or just nearest?
