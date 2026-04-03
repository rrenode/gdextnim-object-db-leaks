## Testing calling a nim static function of a resource
extends Node3D

enum TESTS { 
	JUST_CREATE, CREATE_ADD_TO_EXISTING_MESH, 
	createMeshAndCreateIMesh, createMeshAndIMeshAndAddChild,
	nimCreateLineMeshInstance
	
}
@export var testToRun: TESTS = TESTS.JUST_CREATE

@onready var existingMesh = %ExistingMesh

func _ready() -> void:
	match testToRun:
		TESTS.JUST_CREATE:
			a()
		TESTS.CREATE_ADD_TO_EXISTING_MESH:
			b()
		TESTS.createMeshAndCreateIMesh:
			createMeshAndCreateIMesh()
		TESTS.createMeshAndIMeshAndAddChild:
			createMeshAndIMeshAndAddChild()
		TESTS.nimCreateLineMeshInstance:
			nimCreateLineMeshInstance()

func a() -> void:
	justCreate()

func b() -> void:
	createAndAddToExistingMesh()

func justCreate() -> void:
	##==========================================================================
	## RendererMethod:Compatability & RendererMethod:Forward+ OnClose -> 
	## 		No err. Seems good.
	##==========================================================================
	var imMesh = Draw3D.makeLineMesh(Vector3(0,0,0), Vector3(0, 4, 0))

func createAndAddToExistingMesh() -> void:
	##==========================================================================
	## RendererMethod:Compatability & RendererMethod:Forward+ OnClose -> 
	## 		No err. Seems good.
	##==========================================================================
	## Just closing has no issues...
	## But if you use remote view you get errors and a crash of the game:
	##    No stack traceback available
	##    SIGSEGV: Illegal storage access. (Attempt to read from nil?)
	##		ERROR: BUG: Unreferenced static string to 0: _request_gizmo_for_id
	##			 unref (core/string/string_name.cpp:116)
	##		ERROR: BUG: Unreferenced static string to 0: _enter_world
	##			 unref (core/string/string_name.cpp:116)
	##		ERROR: BUG: Unreferenced static string to 0: .
	##			 unref (core/string/string_name.cpp:116)
	##		ERROR: BUG: Unreferenced static string to 0: Variant
	##			 unref (core/string/string_name.cpp:116)
	##		ERROR: BUG: Unreferenced static string to 0: @warning_ignore_restore
	##			 unref (core/string/string_name.cpp:116)
	##		ERROR: BUG: Unreferenced static string to 0: @warning_ignore_start
	##			 unref (core/string/string_name.cpp:116)
	##		ERROR: BUG: Unreferenced static string to 0: @warning_ignore
	##			 unref (core/string/string_name.cpp:116)
	##		ERROR: BUG: Unreferenced static string to 0: @export_range
	##			 unref (core/string/string_name.cpp:116)
	##		ERROR: BUG: Unreferenced static string to 0: @export_multiline
	##			 unref (core/string/string_name.cpp:116)
	##		ERROR: BUG: Unreferenced static string to 0: @export
	##			 unref (core/string/string_name.cpp:116)
	##		ERROR: BUG: Unreferenced static string to 0: @icon
	##			 unref (core/string/string_name.cpp:116)
	##		ERROR: 7 RID allocations of type '23NavMeshGeometryParser2D' were leaked at exit.
	##		ERROR: 6 RID allocations of type '23NavMeshGeometryParser3D' were leaked at exit.
	##		ERROR: Pages in use exist at exit in PagedAllocator: N7Variant5Pools11BucketLargeE
	##			 ~PagedAllocator (./core/templates/paged_allocator.h:169)
	##==========================================================================
	var imMesh = Draw3D.makeLineMesh(Vector3(0,0,0), Vector3(0, 4, 0))
	existingMesh.mesh = imMesh

func createMeshAndCreateIMesh() -> void:
	## These errors are expected since we do not add the node as a child...
	##==========================================================================
	## RendererMethod:Compatability & RendererMethod:Forward+ OnClose ->
	## 		ERROR: Pages in use exist at exit in PagedAllocator: N20RasterizerSceneGLES323GeometryInstanceSurfaceE
	## 			at: ~PagedAllocator (./core/templates/paged_allocator.h:169)
	## 		ERROR: Pages in use exist at exit in PagedAllocator: N20RasterizerSceneGLES321GeometryInstanceGLES3E
	## 			at: ~PagedAllocator (./core/templates/paged_allocator.h:169)
	## 		ERROR: 1 RID allocations of type 'N5GLES34MeshE' were leaked at exit.
	## 		WARNING: Leaked instance dependency: Bug - did not call instance_notify_deleted when freeing.
	## 			at: ~Dependency (servers/rendering/storage/utilities.cpp:56)
	## 		ERROR: Buffer with GL ID of 31: leaked 24 bytes.
	## 			at: ~Utilities (drivers/gles3/storage/utilities.cpp:108)
	## 		ERROR: 1 RID allocations of type 'N17RendererSceneCull8InstanceE' were leaked at exit.
	##==========================================================================
	var imMesh: ImmediateMesh = Draw3D.makeLineMesh(Vector3(0,0,0), Vector3(0, 4, 0))
	var line: MeshInstance3D = Draw3D.tline(Vector3(0,0,0), Vector3(0, 4, 0))
	line.mesh = imMesh

func createMeshAndIMeshAndAddChild() -> void:
	##==========================================================================
	## RendererMethod:Compatability & RendererMethod:Forward+ OnClose -> 
	## 		No err. Seems good.
	##==========================================================================
	## When going into remote view in editor ->
	##    No stack traceback available
	##    SIGSEGV: Illegal storage access. (Attempt to read from nil?)
	##		ERROR: BUG: Unreferenced static string to 0: _request_gizmo_for_id
	##			 unref (core/string/string_name.cpp:116)
	##		ERROR: BUG: Unreferenced static string to 0: _enter_world
	##			 unref (core/string/string_name.cpp:116)
	##		ERROR: BUG: Unreferenced static string to 0: .
	##			 unref (core/string/string_name.cpp:116)
	##		ERROR: BUG: Unreferenced static string to 0: Variant
	##			 unref (core/string/string_name.cpp:116)
	##		ERROR: BUG: Unreferenced static string to 0: @warning_ignore_restore
	##			 unref (core/string/string_name.cpp:116)
	##		ERROR: BUG: Unreferenced static string to 0: @warning_ignore_start
	##			 unref (core/string/string_name.cpp:116)
	##		ERROR: BUG: Unreferenced static string to 0: @warning_ignore
	##			 unref (core/string/string_name.cpp:116)
	##		ERROR: BUG: Unreferenced static string to 0: @export_range
	##			 unref (core/string/string_name.cpp:116)
	##		ERROR: BUG: Unreferenced static string to 0: @export_multiline
	##			 unref (core/string/string_name.cpp:116)
	##		ERROR: BUG: Unreferenced static string to 0: @export
	##			 unref (core/string/string_name.cpp:116)
	##		ERROR: BUG: Unreferenced static string to 0: @icon
	##			 unref (core/string/string_name.cpp:116)
	##		ERROR: 7 RID allocations of type '23NavMeshGeometryParser2D' were leaked at exit.
	##		ERROR: 6 RID allocations of type '23NavMeshGeometryParser3D' were leaked at exit.
	##		ERROR: Pages in use exist at exit in PagedAllocator: N7Variant5Pools11BucketLargeE
	##			 ~PagedAllocator (./core/templates/paged_allocator.h:169)
	##==========================================================================
	var imMesh: ImmediateMesh = Draw3D.makeLineMesh(Vector3(0,0,0), Vector3(0, 4, 0))
	var line: MeshInstance3D = Draw3D.tline(Vector3(0,0,0), Vector3(0, 4, 0))
	line.mesh = imMesh
	add_child(line)

func nimCreateLineMeshInstance() -> void:
	##==========================================================================
	## RendererMethod:Compatability & RendererMethod:Forward+ OnClose -> 
	## 		No err. Seems good.
	##==========================================================================
	## When going into remote view in editor ->
	##	 No stack traceback available
	##	 SIGSEGV: Illegal storage access. (Attempt to read from nil?)
	##	 Error: BUG: Unreferenced static string to 0: Physics2DConstraintSolveIslands
	## 		at: unref (core/string/string_name.cpp:116)
	## 	Error: BUG: Unreferenced static string to 0: Physics2DConstraintSetup
	## 		at: unref (core/string/string_name.cpp:116)
	## 	Error: BUG: Unreferenced static string to 0: _enter_world
	## 		at: unref (core/string/string_name.cpp:116)
	## 	Error: BUG: Unreferenced static string to 0: .
	## 		at: unref (core/string/string_name.cpp:116)
	## 	Error: BUG: Unreferenced static string to 0: Variant
	## 		at: unref (core/string/string_name.cpp:116)
	## 	Error: BUG: Unreferenced static string to 0: @warning_ignore_restore
	## 		at: unref (core/string/string_name.cpp:116)
	## 	Error: BUG: Unreferenced static string to 0: @warning_ignore_start
	## 		at: unref (core/string/string_name.cpp:116)
	## 	Error: BUG: Unreferenced static string to 0: @warning_ignore
	## 		at: unref (core/string/string_name.cpp:116)
	## 	Error: BUG: Unreferenced static string to 0: @export_range
	## 		at: unref (core/string/string_name.cpp:116)
	## 	Error: BUG: Unreferenced static string to 0: @export_multiline
	## 		at: unref (core/string/string_name.cpp:116)
	## 	Error: BUG: Unreferenced static string to 0: @export
	## 		at: unref (core/string/string_name.cpp:116)
	## 	Error: BUG: Unreferenced static string to 0: @icon
	## 		at: unref (core/string/string_name.cpp:116)
	## 	Error: 7 RID allocations of type '23NavMeshGeometryParser2D' were leaked at exit.
	## 	Error: 6 RID allocations of type '23NavMeshGeometryParser3D' were leaked at exit.
	## 	Error: Pages in use exist at exit in PagedAllocator: N7Variant5Pools11BucketLargeE
	##==========================================================================
	var line: MeshInstance3D = Draw3D.line(Vector3(0,0,0), Vector3(0, 4, 0))
	print(line) #<MeshInstance3D#27699185104>
	print(line is MeshInstance3D) #true
	print(line.mesh) #<Object#null>
	print(line.mesh is ImmediateMesh) #false
	add_child(line)
