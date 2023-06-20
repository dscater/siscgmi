<template>
    <div
        class="modal fade"
        :class="{ show: bModal }"
        id="modal-default"
        aria-modal="true"
        role="dialog"
    >
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h4 class="modal-title" v-text="tituloModal"></h4>
                    <button
                        type="button"
                        class="close"
                        data-dismiss="modal"
                        aria-label="Close"
                        @click="cierraModal"
                    >
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="row">
                            <div
                                class="form-group col-md-12"
                                v-if="accion == 'nuevo'"
                            >
                                <label
                                    :class="{
                                        'text-danger': errors.orden_id,
                                    }"
                                    >Seleccionar Número de Orden de
                                    Trabajo</label
                                >
                                <el-select
                                    placeholder="Seleccionar Número de Orden de Trabajo"
                                    class="w-100"
                                    :class="{
                                        'is-invalid': errors.orden_id,
                                    }"
                                    v-model="oPedidoRepuesto.orden_id"
                                    filterable
                                    clearable
                                    @change="getOrdenWithOrdenGenerada()"
                                >
                                    <el-option
                                        v-for="(
                                            item, index
                                        ) in listOrdenTrabajos"
                                        :key="index"
                                        :value="item.id"
                                        :label="item.id"
                                    ></el-option>
                                </el-select>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.orden_id"
                                    v-text="errors.orden_id[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-12" v-else>
                                <label
                                    :class="{
                                        'text-danger': errors.orden_id,
                                    }"
                                    >Número de Orden de Trabajo</label
                                >
                                <el-input
                                    :class="{
                                        'is-invalid': errors.orden_id,
                                    }"
                                    v-model="oPedidoRepuesto.orden_id"
                                    readonly
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.orden_id"
                                    v-text="errors.orden_id[0]"
                                ></span>
                            </div>
                        </div>
                        <b-skeleton-wrapper
                            :loading="!oOrdenTrabajo"
                            class="w-100"
                        >
                            <template #loading>
                                <b-skeleton-table
                                    :rows="3"
                                    :columns="3"
                                    :table-props="{
                                        bordered: true,
                                        striped: true,
                                    }"
                                >
                                </b-skeleton-table>
                            </template>
                            <div class="row">
                                <div class="col-md-12">
                                    <h4
                                        class="font-weight-bold text-center text-lg"
                                    >
                                        Lista de repuestos
                                    </h4>
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Repuesto</th>
                                                <th>Cantidad requerida</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <template
                                                v-if="
                                                    accion == 'nuevo' &&
                                                    oOrdenTrabajo
                                                        ?.orden_generada
                                                        ?.detalle_repuestos
                                                        .length > 0
                                                "
                                            >
                                                <tr
                                                    v-for="(
                                                        item, index
                                                    ) in oOrdenTrabajo
                                                        ?.orden_generada
                                                        ?.detalle_repuestos"
                                                    :key="index"
                                                >
                                                    <td>{{ index + 1 }}</td>
                                                    <td>
                                                        {{
                                                            item.repuesto
                                                                .full_name
                                                        }}
                                                    </td>
                                                    <td>
                                                        <input
                                                            type="number"
                                                            class="form-control"
                                                            v-model="
                                                                item.cantidad_requerida
                                                            "
                                                        />
                                                    </td>
                                                </tr>
                                            </template>
                                            <template v-else>
                                                <tr
                                                    v-for="(
                                                        item, index
                                                    ) in oPedidoRepuesto.detalle_pedidos"
                                                    :key="index"
                                                >
                                                    <td>{{ index + 1 }}</td>
                                                    <td>
                                                        {{
                                                            item.repuesto
                                                                .full_name
                                                        }}
                                                    </td>
                                                    <td>
                                                        <input
                                                            type="number"
                                                            class="form-control"
                                                            v-model="
                                                                item.cantidad_requerida
                                                            "
                                                        />
                                                    </td>
                                                </tr>
                                            </template>
                                            <!-- <template v-else>
                                                <tr>
                                                    <td
                                                        colspan="6"
                                                        class="text-center font-italic text-gray"
                                                    >
                                                        NO SE AGREGÓ NINGÚN
                                                        REGISTRO
                                                    </td>
                                                </tr>
                                            </template> -->
                                            <!-- <tr>
                                                <td
                                                    colspan="4"
                                                    class="font-weight-bold text-right"
                                                >
                                                    TOTAL
                                                </td>
                                                <td class="font-weight-bold">
                                                    {{ sumaTotal }}
                                                </td>
                                            </tr> -->
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </b-skeleton-wrapper>
                    </form>
                </div>
                <div class="modal-footer justify-content-between">
                    <button
                        type="button"
                        class="btn btn-default"
                        data-dismiss="modal"
                        @click="cierraModal"
                    >
                        Cancelar
                    </button>
                    <el-button
                        type="primary"
                        class="bg-primary"
                        :loading="enviando"
                        :disabled="this.oPedidoRepuesto.orden_id == ''"
                        @click="setRegistroModal()"
                        >{{ textoBoton }}</el-button
                    >
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    props: {
        muestra_modal: {
            type: Boolean,
            default: false,
        },
        accion: {
            type: String,
            default: "nuevo",
        },
        pedido_repuesto: {
            type: Object,
            default: {
                id: 0,
                orden_id: 0,
                orden_trabajo: {
                    fecha_programada: "",
                    subunidad_id: "",
                    gama_id: "",
                    prioridad: "",
                    tiempo: "",
                    dias: "",
                    tipo_mantenimiento: "",
                    estado: "",
                    orden_generada: {
                        id: 0,
                        archivo: "",
                        descripcion_documentacion: "",
                        comentario: "",
                        detalle_repuestos: [],
                        detalle_herramientas: [],
                        detalle_personals: [],
                    },
                },
            },
        },
    },
    watch: {
        pedido_repuesto(newVal) {
            this.oPedidoRepuesto = this.pedido_repuesto;
            this.getOrdenWithOrdenGenerada();
        },
        muestra_modal: function (newVal, oldVal) {
            this.errors = [];
            if (newVal) {
                this.bModal = true;
                this.getOrdenWithOrdenGenerada();
            } else {
                this.bModal = false;
            }
        },
    },
    computed: {
        tituloModal() {
            return "PEDIDO DE REPUESTOS";
        },
        textoBoton() {
            if (this.accion == "edit") {
                return "Actualizar pedido";
            }
            return "Registrar pedido";
        },
        sumaTotal() {
            let sumatoria = 0;
            sumatoria = 0;
            if (
                this.oOrdenTrabajo?.orden_generada?.detalle_repuestos.length > 0
            ) {
                this.oOrdenTrabajo?.orden_generada?.detalle_repuestos.forEach(
                    (elem) => {
                        sumatoria += parseFloat(elem.total);
                    }
                );
            }
            return sumatoria;
        },
    },
    data() {
        return {
            user: JSON.parse(localStorage.getItem("user")),
            bModal: this.muestra_modal,
            enviando: false,
            errors: [],
            oOrdenTrabajo: this.pedido_repuesto.orden_trabajo,
            listOrdenTrabajos: [],
            oPedidoRepuesto: this.pedido_repuesto,
        };
    },
    mounted() {
        this.bModal = this.muestra_modal;
        this.getOrdenTrabajos();
    },
    methods: {
        // obtener listado de ordenes de trabajo
        getOrdenTrabajos() {
            axios.get("/admin/orden_trabajos").then((response) => {
                this.listOrdenTrabajos = response.data.orden_trabajos;
            });
        },
        // obtener orden con su orden generada
        getOrdenWithOrdenGenerada() {
            this.oOrdenTrabajo = null;
            if (this.oPedidoRepuesto.orden_id != "") {
                axios
                    .get(
                        "/admin/orden_trabajos/getWithOrdenGenerada/" +
                            this.oPedidoRepuesto.orden_id
                    )
                    .then((response) => {
                        this.oOrdenTrabajo = response.data.orden_trabajo;
                    });
            } else {
                this.oPedidoRepuesto.orden_id = "";
                this.oOrdenTrabajo = {
                    id: 0,
                    orden_generada: {
                        id: 0,
                        detalle_repuestos: [],
                    },
                };
            }
        },
        // calcular nuevo total al cambiar cantidad de un repuesto
        detectaCambioCantidad(item) {
            item.total = item.costo * item.cantidad_requerida;
        },
        setRegistroModal() {
            this.enviando = true;
            try {
                this.textoBtn = "Enviando...";
                let url = "/admin/pedido_repuestos";
                let datos = {
                    orden_id: this.oPedidoRepuesto.orden_id,
                    detalle_repuestos:
                        this.oOrdenTrabajo.orden_generada.detalle_repuestos,
                };
                if (this.accion == "edit") {
                    url = "/admin/pedido_repuestos/" + this.oPedidoRepuesto.id;
                    datos.detalle_repuestos =
                        this.oPedidoRepuesto.detalle_pedidos;
                    datos["_method"] = "put";
                }
                axios
                    .post(url, datos)
                    .then((response) => {
                        this.enviando = false;
                        if (response.data.sw) {
                            Swal.fire({
                                icon: "success",
                                title: response.data.message,
                                showConfirmButton: false,
                                timer: 1500,
                            });
                            console.log(response.data);
                            this.$emit(
                                "envioModal",
                                response.data.orden_generada
                            );
                            this.limpiaModal();
                        } else {
                            Swal.fire({
                                icon: "info",
                                title: "Atención",
                                html: response.data.message,
                                showConfirmButton: false,
                                timer: 2000,
                            });
                        }
                    })
                    .catch((error) => {
                        this.enviando = false;
                        if (this.accion == "edit") {
                            this.textoBtn = "Actualizar";
                        } else {
                            this.textoBtn = "Registrar";
                        }
                        if (error.response) {
                            if (error.response.status === 422) {
                                this.errors = error.response.data.errors;
                                let mensaje = `<ul class="text-center">`;
                                for (let key in this.errors) {
                                    if (this.errors.hasOwnProperty(key)) {
                                        const value = this.errors[key];
                                        if (Array.isArray(value)) {
                                            value.forEach((error) => {
                                                mensaje += `<li><span>${error.trim()}</span></li>`;
                                            });
                                        }
                                    }
                                }
                                mensaje += `<ul/>`;
                                Swal.fire({
                                    icon: "error",
                                    title: "Completa el formulario",
                                    html: mensaje,
                                    showConfirmButton: true,
                                    confirmButtonColor: "#149FDA",
                                    confirmButtonText: "Aceptar",
                                });
                            }
                            if (
                                error.response.status === 420 ||
                                error.response.status === 419 ||
                                error.response.status === 401
                            ) {
                                window.location = "/";
                            }
                            if (error.response.status === 500) {
                                Swal.fire({
                                    icon: "error",
                                    title: "Error",
                                    html: error.response.data.message,
                                    showConfirmButton: false,
                                    timer: 2000,
                                });
                            }
                        }
                    });
            } catch (e) {
                this.enviando = false;
                console.log(e);
            }
        },
        // Dialog/modal
        cierraModal() {
            this.bModal = false;
            this.$emit("close");
        },
        limpiaModal() {
            this.errors = [];
        },
    },
};
</script>

<style></style>
