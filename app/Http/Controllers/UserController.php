<?php

namespace App\Http\Controllers;

use App\Models\Alerta;
use App\Models\Area;
use App\Models\Cliente;
use App\Models\Equipo;
use App\Models\Herramienta;
use App\Models\HistorialAccion;
use App\Models\MaestroRegistro;
use App\Models\Maquinaria;
use App\Models\Nota;
use App\Models\Notificacion;
use App\Models\Venta;
use App\Models\Producto;
use App\Models\Repuesto;
use App\Models\SeguimientoAprobado;
use App\Models\SeguimientoRectificacion;
use App\Models\SeguimientoTramite;
use App\Models\Sistema;
use App\Models\Subunidad;
use App\Models\Tcont;
use App\Models\User;
use App\Models\VariableControl;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    public $validacion = [
        'nombre' => 'required|min:4',
        'paterno' => 'required|min:4',
        'ci' => 'required|numeric|digits_between:4, 20|unique:users,ci',
        'ci_exp' => 'required',
        'tipo' => 'required',
        'acceso' => 'required',
    ];

    public $mensajes = [
        'nombre.required' => 'Este campo es obligatorio',
        'nombre.min' => 'Debes ingressar al menos 4 carácteres',
        'paterno.required' => 'Este campo es obligatorio',
        'paterno.min' => 'Debes ingresar al menos 4 carácteres',
        'ci.required' => 'Este campo es obligatorio',
        'ci.numeric' => 'Debes ingresar un valor númerico',
        'ci.unique' => 'Este número de C.I. ya fue registrado',
        'ci_exp.required' => 'Este campo es obligatorio',
        'dir.required' => 'Este campo es obligatorio',
        'dir.min' => 'Debes ingresar al menos 4 carácteres',
        'fono.required' => 'Este campo es obligatorio',
        'fono.min' => 'Debes ingresar al menos 4 carácteres',
        'cel.required' => 'Este campo es obligatorio',
        'cel.min' => 'Debes ingresar al menos 4 carácteres',
        'tipo.required' => 'Este campo es obligatorio',
        'correo' => 'nullable|email|unique:users,correo',
    ];

    public $permisos = [
        'ADMINISTRADOR' => [
            'usuarios.index',
            'usuarios.create',
            'usuarios.edit',
            'usuarios.destroy',

            'configuracion.index',
            'configuracion.edit',

            'areas.index',
            'areas.create',
            'areas.edit',
            'areas.destroy',

            'sistemas.index',
            'sistemas.create',
            'sistemas.edit',
            'sistemas.destroy',

            'equipos.index',
            'equipos.create',
            'equipos.edit',
            'equipos.destroy',

            'subunidads.index',
            'subunidads.create',
            'subunidads.edit',
            'subunidads.destroy',

            'maquinarias.index',
            'maquinarias.create',
            'maquinarias.edit',
            'maquinarias.destroy',

            'variable_controls.index',
            'variable_controls.create',
            'variable_controls.edit',
            'variable_controls.destroy',

            'frecuencias.index',
            'frecuencias.create',
            'frecuencias.edit',
            'frecuencias.destroy',

            'herramientas.index',
            'herramientas.create',
            'herramientas.edit',
            'herramientas.destroy',

            'entrada_herramientas.index',
            'entrada_herramientas.create',
            'entrada_herramientas.edit',
            'entrada_herramientas.destroy',

            'repuestos.index',
            'repuestos.create',
            'repuestos.edit',
            'repuestos.destroy',

            'entrada_repuestos.index',
            'entrada_repuestos.create',
            'entrada_repuestos.edit',
            'entrada_repuestos.destroy',

            'personals.index',
            'personals.create',
            'personals.edit',
            'personals.destroy',

            'familias.index',
            'familias.create',
            'familias.edit',
            'familias.destroy',

            'sub_familias.index',
            'sub_familias.create',
            'sub_familias.edit',
            'sub_familias.destroy',

            'gama_mantenimientos.index',
            'gama_mantenimientos.create',
            'gama_mantenimientos.edit',
            'gama_mantenimientos.destroy',

            'plan_mantenimientos.index',
            'plan_mantenimientos.create',
            'plan_mantenimientos.edit',
            'plan_mantenimientos.destroy',

            'orden_trabajos.index',
            'orden_trabajos.create',
            'orden_trabajos.edit',
            'orden_trabajos.destroy',
            "orden_generadas.consultar_ot",

            'orden_generadas.index',
            'orden_generadas.create',
            'orden_generadas.edit',
            'orden_generadas.destroy',

            'pedido_repuestos.index',
            'pedido_repuestos.create',
            'pedido_repuestos.edit',
            'pedido_repuestos.destroy',

            'historial_tiempos.index',
            'historial_tiempos.create',
            'historial_tiempos.edit',
            'historial_tiempos.destroy',

            'reportes.usuarios',
            'reportes.kardex_herramientas',
            'reportes.informacion_herramientas',
        ],
        "GERENTE" => [],
        "GERENTE DE PRODUCCIÓN" => [],
        "JEFE DE MANTENIMIENTO" => [
            'notificacions.index',
        ],
        "SUPERVISOR DE COMPRAS" => [
            'notificacions.index',
        ],
        "AUXILIAR DE MANTENIMIENTO" => [
            'notificacions.index',
        ],
        "AUXILIAR DE ALMACÉN" => [],
        "SERVICIOS" => [],
        "TERCEROS" => [],
    ];


    public function index(Request $request)
    {
        $usuarios = User::where('id', '!=', 1)->get();
        return response()->JSON(['usuarios' => $usuarios, 'total' => count($usuarios)], 200);
    }

    public function store(Request $request)
    {
        if ($request->hasFile('foto')) {
            $this->validacion['foto'] = 'image|mimes:jpeg,jpg,png|max:2048';
        }

        $request->validate($this->validacion, $this->mensajes);
        $cont = 0;
        do {
            $nombre_usuario = User::getNombreUsuario($request->nombre, $request->paterno);
            if ($cont > 0) {
                $nombre_usuario = $nombre_usuario . $cont;
            }
            $request['usuario'] = $nombre_usuario;
            $cont++;
        } while (User::where('usuario', $nombre_usuario)->get()->first());
        $request['password'] = 'NoNulo';
        $request['fecha_registro'] = date('Y-m-d');

        DB::beginTransaction();
        try {
            // crear el Usuario
            $nuevo_usuario = User::create(array_map('mb_strtoupper', $request->except('foto')));
            $nuevo_usuario->password = Hash::make($request->ci);
            $nuevo_usuario->save();
            $nuevo_usuario->foto = 'default.png';
            if ($request->hasFile('foto')) {
                $file = $request->foto;
                $nom_foto = time() . '_' . $nuevo_usuario->usuario . '.' . $file->getClientOriginalExtension();
                $nuevo_usuario->foto = $nom_foto;
                $file->move(public_path() . '/imgs/users/', $nom_foto);
            }
            $nuevo_usuario->correo = mb_strtolower($nuevo_usuario->correo);
            $nuevo_usuario->save();

            if ($nuevo_usuario->tipo == 'CAJA') {
                $nuevo_usuario->caja_usuario()->create([
                    "caja_id" => $request->caja_id,
                ]);
            }

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_usuario, "users");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN USUARIO',
                'datos_original' => $datos_original,
                'modulo' => 'USUARIOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'usuario' => $nuevo_usuario,
                'msj' => 'El registro se realizó de forma correcta',
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function update(Request $request, User $usuario)
    {
        $this->validacion['ci'] = 'required|min:4|numeric|unique:users,ci,' . $usuario->id;
        $this->validacion['correo'] = 'nullable|email|unique:users,correo,' . $usuario->id;
        if ($request->hasFile('foto')) {
            $this->validacion['foto'] = 'image|mimes:jpeg,jpg,png|max:2048';
        }
        if ($request->tipo == 'CAJA') {
            $this->validacion['caja_id'] = 'required';
        }

        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($usuario, "users");
            $usuario->update(array_map('mb_strtoupper', $request->except('foto')));
            if ($usuario->correo == "") {
                $usuario->correo = NULL;
            }

            if ($request->hasFile('foto')) {
                $antiguo = $usuario->foto;
                if ($antiguo != 'default.png') {
                    \File::delete(public_path() . '/imgs/users/' . $antiguo);
                }
                $file = $request->foto;
                $nom_foto = time() . '_' . $usuario->usuario . '.' . $file->getClientOriginalExtension();
                $usuario->foto = $nom_foto;
                $file->move(public_path() . '/imgs/users/', $nom_foto);
            }
            $usuario->correo = mb_strtolower($usuario->correo);
            $usuario->save();

            $datos_nuevo = HistorialAccion::getDetalleRegistro($usuario, "users");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN USUARIO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'USUARIOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'usuario' => $usuario,
                'msj' => 'El registro se actualizó de forma correcta'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function show(User $usuario)
    {
        return response()->JSON([
            'sw' => true,
            'usuario' => $usuario
        ], 200);
    }

    public function actualizaContrasenia(User $usuario, Request $request)
    {
        $request->validate([
            'password_actual' => ['required', function ($attribute, $value, $fail) use ($usuario, $request) {
                if (!\Hash::check($request->password_actual, $usuario->password)) {
                    return $fail(__('La contraseña no coincide con la actual.'));
                }
            }],
            'password' => 'required|confirmed|min:4',
            'password_confirmation' => 'required|min:4'
        ]);


        DB::beginTransaction();
        try {
            $usuario->password = Hash::make($request->password);
            $usuario->save();
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'msj' => 'La contraseña se actualizó correctamente'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function actualizaFoto(User $usuario, Request $request)
    {
        DB::beginTransaction();
        try {

            if ($request->hasFile('foto')) {
                $antiguo = $usuario->foto;
                if ($antiguo != 'default.png') {
                    \File::delete(public_path() . '/imgs/users/' . $antiguo);
                }
                $file = $request->foto;
                $nom_foto = time() . '_' . $usuario->usuario . '.' . $file->getClientOriginalExtension();
                $usuario->foto = $nom_foto;
                $file->move(public_path() . '/imgs/users/', $nom_foto);
            }
            $usuario->save();
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'usuario' => $usuario,
                'msj' => 'Foto actualizada con éxito'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function destroy(User $usuario)
    {
        DB::beginTransaction();
        try {
            $antiguo = $usuario->foto;
            if ($antiguo != 'default.png') {
                \File::delete(public_path() . '/imgs/users/' . $antiguo);
            }
            $datos_original = HistorialAccion::getDetalleRegistro($usuario, "users");
            $usuario->delete();

            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN USUARIO',
                'datos_original' => $datos_original,
                'modulo' => 'USUARIOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'msj' => 'El registro se eliminó correctamente'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function getPermisos(User $usuario)
    {
        $tipo = $usuario->tipo;
        return response()->JSON($this->permisos[$tipo]);
    }

    public function getInfoBox()
    {
        $tipo = Auth::user()->tipo;
        $array_infos = [];
        if (in_array('usuarios.index', $this->permisos[$tipo])) {
            $array_infos[] = [
                'label' => 'Usuarios',
                'cantidad' => count(User::where('id', '!=', 1)->get()),
                'color' => 'bg-info',
                'icon' => 'fas fa-users',
            ];
        }
        if (in_array('areas.index', $this->permisos[$tipo])) {
            $array_infos[] = [
                'label' => 'Áreas',
                'cantidad' => count(Area::all()),
                'color' => 'bg-primary',
                'icon' => 'fas fa-list',
            ];
        }
        if (in_array('sistemas.index', $this->permisos[$tipo])) {
            $array_infos[] = [
                'label' => 'Sistemas',
                'cantidad' => count(Sistema::all()),
                'color' => 'bg-danger',
                'icon' => 'fas fa-list',
            ];
        }
        if (in_array('equipos.index', $this->permisos[$tipo])) {
            $array_infos[] = [
                'label' => 'Equipos',
                'cantidad' => count(Equipo::all()),
                'color' => 'bg-warning',
                'icon' => 'fas fa-list',
            ];
        }
        if (in_array('subinidads.index', $this->permisos[$tipo])) {
            $array_infos[] = [
                'label' => 'Subunidades',
                'cantidad' => count(Subunidad::all()),
                'color' => 'bg-success',
                'icon' => 'fas fa-tags',
            ];
        }
        if (in_array('maquinarias.index', $this->permisos[$tipo])) {
            $array_infos[] = [
                'label' => 'Maquinarias',
                'cantidad' => count(Maquinaria::all()),
                'color' => 'bg-navy',
                'icon' => 'fas fa-truck-loading',
            ];
        }
        if (in_array('variable_controls.index', $this->permisos[$tipo])) {
            $array_infos[] = [
                'label' => 'Variables de control',
                'cantidad' => count(VariableControl::all()),
                'color' => 'bg-orange',
                'icon' => 'fas fa-tasks',
            ];
        }
        if (in_array('herramientas.index', $this->permisos[$tipo])) {
            $array_infos[] = [
                'label' => 'Herramientas y Equipos de protección',
                'cantidad' => count(Herramienta::all()),
                'color' => 'bg-primary',
                'icon' => 'fas fa-boxes',
            ];
        }
        if (in_array('repuestos.index', $this->permisos[$tipo])) {
            $array_infos[] = [
                'label' => 'Repuestos e Insumos',
                'cantidad' => count(Repuesto::all()),
                'color' => 'bg-info',
                'icon' => 'fas fa-boxes',
            ];
        }
        return response()->JSON($array_infos);
    }

    public function userActual()
    {
        return response()->JSON(Auth::user());
    }

    public function getUsuario(User $usuario)
    {
        return response()->JSON($usuario);
    }

    public function getUsuarioTipo(Request $request)
    {
        $tipo = $request->tipo;
        $usuarios = [];
        if ($tipo != "todos") {
            if (is_array($tipo)) {
                $usuarios = User::where("id", "!=", 1)->whereIn("tipo", $tipo)->get();
            } else {
                $usuarios = User::where("id", "!=", 1)->where("tipo", $tipo)->get();
            }
        } else {
            $usuarios = User::where("id", "!=", 1)->get();
        }
        return response()->JSON($usuarios);
    }
}
