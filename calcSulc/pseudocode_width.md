# calcSulc
## sulcal width
1. load pial surface, Dest parcel annot
1. currently require name of sulci (wrt to Dest annot) be specified
  - make list of valid sulci in Dest, will be useful in testing and establishing which ones are 'supported' here
1. isolate faces associated with desired parcel
1. determine which vertices are associated with faces of desired parcel and another (i.e., edges of the parcel)
1. calculate distances between all edge vertices
  - find nearest vertex, excluding vertices that are locally connected by faces (shared edges)
1. ...look at distribution of values for a given sulci
1. iterate through list of sulci provided

#### alternate estimation approach
- measure distance from vertex, normal to mesh, until collides with surface
